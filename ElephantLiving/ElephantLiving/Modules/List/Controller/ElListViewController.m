//
//  ElListViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElListViewController.h"
#import "ElMacro.h"
#import "ElNormalListTableViewCell.h"
#import "AVOSCloud.h"
#import "AVUser+ElClassMap.h"
#import "_User.h"
#import "UIImage+Categories.h"
#import "MJRefresh.h"

static NSString *const normalList = @"normalList";
static NSString *const first = @"firstCell";

@interface ElListViewController ()

<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong)UITableView *listTableView;

@property (nonatomic, strong) NSMutableArray *userInfoArray;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *imageViewNO2;

@property (nonatomic, strong) UIImageView *imageViewNO3;

@property (nonatomic, strong) UILabel *nikenameLabelOfFirst;

@property (nonatomic, strong) UILabel *charmLabelOfFirst;

@property (nonatomic, strong) UILabel *nikenameLabelOfSecond;

@property (nonatomic, strong) UILabel *charmLabelOfSecond;

@property (nonatomic, strong) UILabel *nikenameLabelOfThird;

@property (nonatomic, strong) UILabel *charmLabelOfThird;

@end

@implementation ElListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:SCREEN_RECT];
    backgroundImageView.image = [UIImage imageNamed:@"景3.jpg"];
    [self.view addSubview:backgroundImageView];
    
    [self createTableView];
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4)];
    _listTableView.tableHeaderView = _topView;
    [self getUserInfo];
    [self creatTopView];
    

    
}

- (void)getUserInfo {
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
//    query.cachePolicy = 3;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            if (_userInfoArray.count > 0) {
                [_userInfoArray removeAllObjects];
            }
            
            self.userInfoArray = [NSMutableArray arrayWithArray:objects];
            //  按魅力值排序
            for (NSInteger i = 0; i < _userInfoArray.count ; i++)
            {
                for (NSInteger j = i; j < _userInfoArray.count; j++)
                {
                    _User *model_i  = _userInfoArray[i];
                    _User *model_j = _userInfoArray[j];
                    if(model_i.charm < model_j.charm)
                    {
                        //交换
                        [_userInfoArray replaceObjectAtIndex:i withObject:model_j];
                        [_userInfoArray replaceObjectAtIndex:j withObject:model_i];
                    }    
                }
            }
            [_listTableView reloadData];
            
            
            AVFile *file = [AVFile fileWithURL:[[_userInfoArray firstObject] headImage]];
            [file getThumbnail:YES width:0 height:0 withBlock:^(UIImage *image, NSError *error) {
                if (!error) {
                    _imageView.image = image;
                    [_topView addSubview:_imageView];
                    [_topView sendSubviewToBack:_imageView];
                }else {
                    NSLog(@"%@",error);
                }
            }];
            _nikenameLabelOfFirst.text = [[_userInfoArray firstObject] username];
            _charmLabelOfFirst.text = [NSString stringWithFormat:@"%ld",[[_userInfoArray firstObject] charm]];
            
            AVFile *secondFile = [AVFile fileWithURL:[[_userInfoArray objectAtIndex:1] headImage]];
            [secondFile getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
                if (!error) {
                    _imageViewNO2.image = image;
                    [_topView addSubview:_imageViewNO2];
                    [_topView sendSubviewToBack:_imageViewNO2];
                }else {
                    NSLog(@"%@",error);
                }
            }];
            _nikenameLabelOfSecond.text = [[_userInfoArray objectAtIndex:1] username];
            _charmLabelOfSecond.text = [NSString stringWithFormat:@"%ld",[[_userInfoArray objectAtIndex:1] charm]];
            
            AVFile *thirdFile = [AVFile fileWithURL:[[_userInfoArray objectAtIndex:2] headImage]];
            [thirdFile getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
                if (!error) {
                    _imageViewNO3.image = image;
                    [_topView addSubview:_imageViewNO3];
                    [_topView sendSubviewToBack:_imageViewNO3];
                }else {
                    NSLog(@"%@",error);
                }
            }];
            _nikenameLabelOfThird.text = [[_userInfoArray objectAtIndex:2] username];
            _charmLabelOfThird.text = [NSString stringWithFormat:@"%ld",[[_userInfoArray objectAtIndex:2] charm]];
        }
    }];
}

#pragma mark - 创建tableView
- (void)createTableView {
    
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108) style:UITableViewStylePlain];
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.rowHeight = 90;
    _listTableView.showsVerticalScrollIndicator = NO;
    [self.view                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  addSubview:_listTableView];
    
   
    [_listTableView registerClass:[ElNormalListTableViewCell class] forCellReuseIdentifier:normalList];
    
    _listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getUserInfo];
        [_listTableView.mj_header endRefreshing];
    }];
    _listTableView.mj_header.automaticallyChangeAlpha = YES;
}


#pragma mark - 顶部排名视图
- (void)creatTopView {
    
    // 第一名
    UIImageView *firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.25, 0, SCREEN_WIDTH * 0.5, SCREEN_WIDTH * 0.3)];
    firstImage.image = [UIImage imageNamed:@"me_yp_no.1_"];
    [_topView addSubview:firstImage];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.backgroundColor = [UIColor clearColor];
    firstButton.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.21, SCREEN_WIDTH * 0.21);
    firstButton.layer.cornerRadius = SCREEN_WIDTH * 0.23 / 2;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.4, SCREEN_HEIGHT * 0.037, SCREEN_WIDTH * 0.21, SCREEN_WIDTH * 0.21)];
    _imageView.layer.cornerRadius = SCREEN_WIDTH * 0.21 / 2;
    _imageView.clipsToBounds = YES;
    [_imageView addSubview:firstButton];
    

    self.nikenameLabelOfFirst = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.39, SCREEN_WIDTH * 0.28 + 10, SCREEN_WIDTH * 0.22, SCREEN_WIDTH * 0.06)];
    _nikenameLabelOfFirst.backgroundColor = [UIColor clearColor];
    _nikenameLabelOfFirst.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:_nikenameLabelOfFirst];
    
    self.charmLabelOfFirst = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.41, SCREEN_WIDTH * 0.34 + 10, SCREEN_WIDTH * 0.2, SCREEN_WIDTH * 0.04)];
    _charmLabelOfFirst.textAlignment = NSTextAlignmentCenter;
    _charmLabelOfFirst.font = [UIFont systemFontOfSize:15];
    _charmLabelOfFirst.numberOfLines = 0;
    [_charmLabelOfFirst sizeToFit];
    [_topView addSubview:_charmLabelOfFirst];
    
    // 第二名
    UIImageView *secondImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, SCREEN_WIDTH * 0.27+ 15, SCREEN_WIDTH * 0.32, SCREEN_WIDTH * 0.24)];
    secondImage.image = [UIImage imageNamed:@"me_yp_no.2_"];
    [_topView addSubview:secondImage];
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.2, SCREEN_WIDTH * 0.2);
    [secondImage addSubview:secondButton];
    
    self.imageViewNO2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.114, SCREEN_HEIGHT * 0.175, SCREEN_WIDTH * 0.195, SCREEN_WIDTH * 0.195)];
    _imageViewNO2.layer.cornerRadius = SCREEN_WIDTH * 0.195 / 2;
    _imageViewNO2.clipsToBounds = YES;
    [_imageViewNO2 addSubview:secondButton];
    
    self.nikenameLabelOfSecond = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.115, SCREEN_WIDTH * 0.52 + 15, SCREEN_WIDTH * 0.2, SCREEN_WIDTH * 0.06)];
    _nikenameLabelOfSecond.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:_nikenameLabelOfSecond];
    
    self.charmLabelOfSecond = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.14, SCREEN_WIDTH * 0.58 + 15, SCREEN_WIDTH * 0.17, SCREEN_WIDTH * 0.04)];
    _charmLabelOfSecond.textAlignment = NSTextAlignmentCenter;
    _charmLabelOfSecond.font = [UIFont systemFontOfSize:15];
    _charmLabelOfSecond.numberOfLines = 0;
    [_charmLabelOfSecond sizeToFit];
    [_topView addSubview:_charmLabelOfSecond];
    
    // 第三名
    UIImageView *thirdImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.71, SCREEN_WIDTH * 0.27 + 15, SCREEN_WIDTH * 0.24, SCREEN_WIDTH * 0.24)];
    thirdImage.image = [UIImage imageNamed:@"me_yp_no.3_"];
    [_topView addSubview:thirdImage];
    
    UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.2, SCREEN_WIDTH * 0.2);
    
    self.imageViewNO3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.73, SCREEN_HEIGHT * 0.174, SCREEN_WIDTH * 0.195, SCREEN_WIDTH * 0.195)];
    _imageViewNO3.layer.cornerRadius = SCREEN_WIDTH * 0.195 / 2;
    _imageViewNO3.clipsToBounds = YES;
    [_imageViewNO3 addSubview:thirdButton];
    
    self.nikenameLabelOfThird = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.73, SCREEN_WIDTH * 0.52 + 15, SCREEN_WIDTH * 0.21, SCREEN_WIDTH * 0.06)];
    _nikenameLabelOfThird.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:_nikenameLabelOfThird];
    
    self.charmLabelOfThird = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.77, SCREEN_WIDTH * 0.58 + 15, SCREEN_WIDTH * 0.17, SCREEN_WIDTH * 0.04)];
    _charmLabelOfThird.textAlignment = NSTextAlignmentCenter;
    _charmLabelOfThird.font = [UIFont systemFontOfSize:15];
    _charmLabelOfThird.numberOfLines = 0;
    [_charmLabelOfThird sizeToFit];
    [_topView addSubview:_charmLabelOfThird];
}


#pragma mark - tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _userInfoArray.count - 3;
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ElNormalListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalList];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.listNumber = indexPath.row + 4;
    cell.nikenameText = [_userInfoArray[indexPath.row + 3] username];
    cell.charmText = [NSString stringWithFormat: @"%ld",[_userInfoArray[indexPath.row + 3] charm]];
    
    cell.headerImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_userInfoArray[indexPath.row + 3] headImage]]]];
    
    return cell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

