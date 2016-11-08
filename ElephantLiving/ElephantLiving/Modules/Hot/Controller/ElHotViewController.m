//
//  ElHotViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElHotViewController.h"
#import "ElHotCollectionViewCell.h"
#import "ElHotCarouselView.h"
#import "ElWatchViewController.h"
#import "ElHotTableViewCell.h"
#import "ElOtherLiveModel.h"
#import "AVIMClient.h"
#import "LiveRoom.h"
#import "AVObject+ElClassMap.h"

static NSString *const identifier = @"cell";
static NSString *const carousel = @"carousel";
@interface ElHotViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) ElHotCarouselView *carouselView;
@property (nonatomic, strong) NSMutableArray *otherLiveArray;
@property (nonatomic, strong) LiveRoom *liveRoom;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AVIMClient *client;
@end

@implementation ElHotViewController



- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [self deleteElLiveRoom];
    [self getOtherLiveRoomInfo];
}

- (void)getElLiveRoomInfo{
    AVQuery *query = [AVQuery queryWithClassName:@"LiveRoom"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            self.otherLiveArray = [NSMutableArray arrayWithArray:objects];
            [_tableView reloadData];
        }
    }];
}

- (void)deleteElLiveRoom {
    AVQuery *query = [AVQuery queryWithClassName:@"LiveRoom"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (LiveRoom *liveRoom in objects) {
                [liveRoom deleteInBackground];
            }
        }
    }];
}

- (void)getOtherLiveRoomInfo {
    
    NSURL *url = [NSURL URLWithString:@"http://live.9158.com/Room/GetHotLive_v2?lon=0.0&province=&lat=0.0&page=1&type=1"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"live.9158.com" forHTTPHeaderField:@"Host"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSDictionary *data = [result objectForKey:@"data"];
                NSArray *listArray = [data objectForKey:@"list"];
                for (NSDictionary *dic in listArray) {
                    ElOtherLiveModel *model = [[ElOtherLiveModel alloc] initWithDic:dic];
                    [self saveElLiveInfo:model array:_otherLiveArray];

                }
            }
        });
    }];
    [dataTask resume];
}

- (void)saveElLiveInfo:(ElOtherLiveModel *)model array :(NSArray *)array{
    
    self.liveRoom = [[LiveRoom alloc] initWithClassName:NSStringFromClass([LiveRoom class])];
    /**
     *  拉流地址
     */
    _liveRoom.pullUrl = model.flv;
    /**
     *  观看人数
     */
    _liveRoom.view_count = model.allnum;
    /**
     *  主播昵称
     */
    _liveRoom.host_name = model.myname;
    /**
     *  主播头像
     */
    _liveRoom.headerImage = model.smallpic;
    /**
     *  封面图
     */
    _liveRoom.coverImage = model.bigpic;
    /**
     *  主播等级
     */
    _liveRoom.level = model.starlevel;
    
        [_liveRoom saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                NSLog(@"直播间信息保存成功");
            } else {
                NSLog(@"创建直播对象出错 %@", error);
            }
        }];
        [self getElLiveRoomInfo];
}

- (void)viewDidLoad {
    self.otherLiveArray = [NSMutableArray array];
    [self createTableView];
    [self deleteElLiveRoom];
//    [self getOtherLiveRoomInfo];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 420;
    [self.view addSubview:_tableView];
    
    self.carouselView = [[ElHotCarouselView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    _carouselView.imageArray = @[@"轮播1", @"轮播2", @"轮播3", @"轮播4", @"轮播5"];
    _tableView.tableHeaderView = _carouselView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _otherLiveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LiveRoom *liveRoom = _otherLiveArray[indexPath.row];
    ElHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ElHotTableViewCell" owner:nil options:nil];
        cell = [nib firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = liveRoom.host_name;
    cell.viewCount = liveRoom.view_count;
    cell.level = liveRoom.level;
    cell.iconImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:liveRoom.headerImage]]];
    cell.coverImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:liveRoom.coverImage]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveRoom *liveRoom = _otherLiveArray[indexPath.row];
    self.client = [[AVIMClient alloc] initWithClientId:liveRoom.host_name];
    [_client openWithCallback:^(BOOL succeeded, NSError * _Nullable error) {
        NSString *topic = liveRoom.host_name;
        NSDictionary *dic = @{@"topic":topic};
        [_client createConversationWithName:topic clientIds:@[] attributes:dic options:AVIMConversationOptionTransient callback:^(AVIMConversation * _Nullable conversation, NSError * _Nullable error) {
        }];
    }];
    [self.delegate presentWatchControllerWithLiveRoom:liveRoom];
}


@end
