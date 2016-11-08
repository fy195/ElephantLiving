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

static NSString *const normalList = @"normalList";
static NSString *const first = @"firstCell";

@interface ElListViewController ()

<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong)UITableView *listTableView;

@property (nonatomic, strong) NSMutableArray *userInfoArray;

@end

@implementation ElListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:SCREEN_RECT];
    backgroundImageView.image = [UIImage imageNamed:@"啊啊啊啊啊.jpeg"];
    [self.view addSubview:backgroundImageView];
    
    
    [self getUserInfo];

    
}

- (void)getUserInfo {
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@",error);
        } else {
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
            [self createTableView];
            [self creatTopView];
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

}


#pragma mark - 顶部排名视图
- (void)creatTopView {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4)];
    _listTableView.tableHeaderView = topView;
    
    
    // 第一名
    UIImageView *firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.25, 0, SCREEN_WIDTH * 0.5, SCREEN_WIDTH * 0.3)];
    firstImage.image = [UIImage imageNamed:@"me_yp_no.1_"];
    [topView addSubview:firstImage];
    
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.backgroundColor = [UIColor clearColor];
    firstButton.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.21, SCREEN_WIDTH * 0.21);
    firstButton.layer.cornerRadius = SCREEN_WIDTH * 0.23 / 2;
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.4, SCREEN_HEIGHT * 0.037, SCREEN_WIDTH * 0.21, SCREEN_WIDTH * 0.21)];
    imageView.backgroundColor = [UIColor cyanColor];
    imageView.layer.cornerRadius = SCREEN_WIDTH * 0.21 / 2;
    imageView.clipsToBounds = YES;
    
    

    AVFile *file = [AVFile fileWithURL:[[_userInfoArray firstObject] headImage]];
    
    [file getThumbnail:YES width:0 height:0 withBlock:^(UIImage *image, NSError *error) {
        if (!error) {
            imageView.image = image;
            
            [topView addSubview:imageView];
            
            [topView sendSubviewToBack:imageView];
            
        }else {
            NSLog(@"%@",error);
        }
    }];
    
    [imageView addSubview:firstButton];
    
    
    
    UILabel *nikenameLabelOfFirst = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.39, SCREEN_WIDTH * 0.28 + 10, SCREEN_WIDTH * 0.22, SCREEN_WIDTH * 0.06)];
    nikenameLabelOfFirst.text = [[_userInfoArray firstObject] username];
    nikenameLabelOfFirst.backgroundColor = [UIColor clearColor];
    nikenameLabelOfFirst.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:nikenameLabelOfFirst];
    
    UILabel *charmLabelOfFirst = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.41, SCREEN_WIDTH * 0.34 + 10, SCREEN_WIDTH * 0.2, SCREEN_WIDTH * 0.04)];
    charmLabelOfFirst.textAlignment = NSTextAlignmentCenter;
    charmLabelOfFirst.font = [UIFont systemFontOfSize:15];
    charmLabelOfFirst.text = [NSString stringWithFormat:@"%ld",[[_userInfoArray firstObject] charm]];
    charmLabelOfFirst.numberOfLines = 0;
    [charmLabelOfFirst sizeToFit];
    [topView addSubview:charmLabelOfFirst];
    
    
    // 第二名
    UIImageView *secondImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, SCREEN_WIDTH * 0.27+ 15, SCREEN_WIDTH * 0.32, SCREEN_WIDTH * 0.24)];
    secondImage.image = [UIImage imageNamed:@"me_yp_no.2_"];
    [topView addSubview:secondImage];
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.2, SCREEN_WIDTH * 0.2);
    [secondImage addSubview:secondButton];
    
    UIImageView *imageViewNO2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.114, SCREEN_HEIGHT * 0.175, SCREEN_WIDTH * 0.195, SCREEN_WIDTH * 0.195)];
    imageViewNO2.layer.cornerRadius = SCREEN_WIDTH * 0.195 / 2;
    imageViewNO2.clipsToBounds = YES;
    
    AVFile *secondFile = [AVFile fileWithURL:[[_userInfoArray objectAtIndex:1] headImage]];
    [secondFile getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
        if (!error) {
            imageViewNO2.image = image;
            [topView addSubview:imageViewNO2];
            [topView sendSubviewToBack:imageViewNO2];
        }else {
            NSLog(@"%@",error);
        }
    }];
    
    [imageViewNO2 addSubview:secondButton];
    
    
    UILabel *nikenameLabelOfSecond = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.115, SCREEN_WIDTH * 0.52 + 15, SCREEN_WIDTH * 0.2, SCREEN_WIDTH * 0.06)];
    nikenameLabelOfSecond.text = [[_userInfoArray objectAtIndex:1] username];
    nikenameLabelOfSecond.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:nikenameLabelOfSecond];
    
    UILabel *charmLabelOfSecond = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.14, SCREEN_WIDTH * 0.58 + 15, SCREEN_WIDTH * 0.17, SCREEN_WIDTH * 0.04)];
    charmLabelOfSecond.text = [NSString stringWithFormat:@"%ld",[[_userInfoArray objectAtIndex:1] charm]];
    charmLabelOfSecond.textAlignment = NSTextAlignmentCenter;
    charmLabelOfSecond.font = [UIFont systemFontOfSize:15];
    charmLabelOfSecond.numberOfLines = 0;
    [charmLabelOfSecond sizeToFit];
    [topView addSubview:charmLabelOfSecond];
    
    
    // 第三名
    UIImageView *thirdImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.71, SCREEN_WIDTH * 0.27 + 15, SCREEN_WIDTH * 0.24, SCREEN_WIDTH * 0.24)];
    thirdImage.image = [UIImage imageNamed:@"me_yp_no.3_"];
    [topView addSubview:thirdImage];
    
    UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.2, SCREEN_WIDTH * 0.2);
    
    
    UIImageView *imageViewNO3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.73, SCREEN_HEIGHT * 0.174, SCREEN_WIDTH * 0.195, SCREEN_WIDTH * 0.195)];
    imageViewNO3.layer.cornerRadius = SCREEN_WIDTH * 0.195 / 2;
    imageViewNO3.clipsToBounds = YES;
    
    AVFile *thirdFile = [AVFile fileWithURL:[[_userInfoArray objectAtIndex:2] headImage]];
    [thirdFile getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
        if (!error) {
            imageViewNO3.image = image;
            [topView addSubview:imageViewNO3];
            [topView sendSubviewToBack:imageViewNO3];
        }else {
            NSLog(@"%@",error);
        }
    }];
    
    [imageViewNO3 addSubview:thirdButton];
    
    UILabel *nikenameLabelOfThird = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.73, SCREEN_WIDTH * 0.52 + 15, SCREEN_WIDTH * 0.21, SCREEN_WIDTH * 0.06)];
    nikenameLabelOfThird.text = [[_userInfoArray objectAtIndex:2] username];
    nikenameLabelOfThird.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:nikenameLabelOfThird];
    
    UILabel *charmLabelOfThird = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.77, SCREEN_WIDTH * 0.58 + 15, SCREEN_WIDTH * 0.17, SCREEN_WIDTH * 0.04)];
    charmLabelOfThird.text = [NSString stringWithFormat:@"%ld",[[_userInfoArray objectAtIndex:2] charm]];
    charmLabelOfThird.textAlignment = NSTextAlignmentCenter;
    charmLabelOfThird.font = [UIFont systemFontOfSize:15];
    charmLabelOfThird.numberOfLines = 0;
    [charmLabelOfThird sizeToFit];
    [topView addSubview:charmLabelOfThird];
    
    
    
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
    
//    AVFile *file = [AVFile fileWithURL:[_userInfoArray[indexPath.row + 3] headImage]];
//    [file getThumbnail:YES width:100 height:100 withBlock:^(UIImage * _Nullable image, NSError * _Nullable error) {
//        if (!error) {
//            cell.headerImage = image;
//        }else {
//            NSLog(@"%@",error);
//        }
//    }];
    
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

