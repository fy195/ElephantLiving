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
#import "ElLivingRoom.h"
#import "AVIMClient.h"

static NSString *const identifier = @"cell";
static NSString *const carousel = @"carousel";
@interface ElHotViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) ElHotCarouselView *carouselView;
@property (nonatomic, strong) NSMutableArray *otherLiveArray;
@property (nonatomic, strong) ElLivingRoom *liveRoom;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AVIMClient *client;
@end

@implementation ElHotViewController
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
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
//                    [self setElLiveInfo:model];
                }
            }
        });
    }];
    [dataTask resume];

}

- (void)setElLiveInfo:(ElOtherLiveModel *)model{

    self.liveRoom = [[ElLivingRoom alloc] initWithClassName:@"LiveRoom"];
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
    
    /**
     *  封面图
     */
    
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
    [_otherLiveArray addObject:_liveRoom];
    [_tableView reloadData];
}


- (void)viewDidLoad {
    [self createCarouselView];
    self.otherLiveArray = [NSMutableArray array];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(100, 300, 100, 100);
    _button.backgroundColor = [UIColor colorWithRed:0.9418 green:1.0 blue:0.7947 alpha:1.0];
    [self.view addSubview:_button];
    [self createTableView];
    [self getOtherLiveRoomInfo];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _carouselView.height + _carouselView.y, SCREEN_WIDTH, SCREEN_HEIGHT - _carouselView.height - _carouselView.y) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor orangeColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 200;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _otherLiveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ElLivingRoom *liveRoom = _otherLiveArray[indexPath.row];
    ElHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[ElHotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor colorWithRed:1.000 green:0.934 blue:0.235 alpha:1.000];
    cell.name = liveRoom.host_name;
    cell.viewCount = liveRoom.view_count;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ElLivingRoom *liveRoom = _otherLiveArray[indexPath.row];
    self.client = [[AVIMClient alloc] initWithClientId:liveRoom.host_name];
    [_client openWithCallback:^(BOOL succeeded, NSError * _Nullable error) {
        NSString *topic = liveRoom.objectId;
        NSDictionary *dic = @{@"topic":topic};
        [_client createConversationWithName:topic clientIds:@[] attributes:dic options:AVIMConversationOptionTransient callback:^(AVIMConversation * _Nullable conversation, NSError * _Nullable error) {
            if (!error) {
//                self.currentConversation = conversation;
            }
        }];
    }];
    [self.delegate presentWatchControllerWithLiveRoom:liveRoom];
}

- (void)createCarouselView {
    self.carouselView = [[ElHotCarouselView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    _carouselView.imageArray = @[@"1", @"2", @"1", @"2", @"1"];
    [self.view addSubview:_carouselView];
}


@end
