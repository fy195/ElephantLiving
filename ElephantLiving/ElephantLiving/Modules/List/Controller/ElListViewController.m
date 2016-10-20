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


static NSString *const normalList = @"normalList";
static NSString *const first = @"firstCell";

@interface ElListViewController ()

<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong)UITableView *listTableView;

@end

@implementation ElListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    
    [self creatTopView];
    
    
}


#pragma mark - 创建tableView
- (void)createTableView {
    
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _listTableView.backgroundColor = [UIColor whiteColor];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.rowHeight = 90;
    _listTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_listTableView];
    
    _listTableView.contentInset = UIEdgeInsetsMake(280, 0, 0, 0);
    
    [_listTableView registerClass:[ElNormalListTableViewCell class] forCellReuseIdentifier:normalList];
    
}


#pragma mark - 顶部排名视图
- (void)creatTopView {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, -280, SCREEN_WIDTH, 280)];
    [_listTableView addSubview:topView];
    
    
    // 第一名
    UIImageView *firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.25, 0, SCREEN_WIDTH * 0.5, SCREEN_WIDTH * 0.3)];
    firstImage.image = [UIImage imageNamed:@"me_yp_no.1_"];
    [topView addSubview:firstImage];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.6, SCREEN_WIDTH * 0.35);
    [firstImage addSubview:firstButton];
    
    
    UILabel *nikenameLabelOfFirst = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.39, SCREEN_WIDTH * 0.28 + 10, SCREEN_WIDTH * 0.22, SCREEN_WIDTH * 0.06)];
    nikenameLabelOfFirst.text = @"亮哥";
    nikenameLabelOfFirst.backgroundColor = [UIColor whiteColor];
    nikenameLabelOfFirst.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:nikenameLabelOfFirst];
    
    UILabel *charmLabelOfFirst = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.41, SCREEN_WIDTH * 0.34 + 10, SCREEN_WIDTH * 0.2, SCREEN_WIDTH * 0.04)];
    charmLabelOfFirst.textAlignment = NSTextAlignmentCenter;
    charmLabelOfFirst.text = @"9999999";
    [topView addSubview:charmLabelOfFirst];
    
    
    // 第二名
    UIImageView *secondImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, SCREEN_WIDTH * 0.27+ 15, SCREEN_WIDTH * 0.32, SCREEN_WIDTH * 0.24)];
    secondImage.image = [UIImage imageNamed:@"me_yp_no.2_"];
    [topView addSubview:secondImage];
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.24, SCREEN_WIDTH * 0.24);
    [secondImage addSubview:secondButton];
    
    UILabel *nikenameLabelOfSecond = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.09, SCREEN_WIDTH * 0.52 + 15, SCREEN_WIDTH * 0.2, SCREEN_WIDTH * 0.06)];
    nikenameLabelOfSecond.text = @"学委";
    nikenameLabelOfSecond.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:nikenameLabelOfSecond];
    
    UILabel *charmLabelOfSecond = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.11, SCREEN_WIDTH * 0.58 + 15, SCREEN_WIDTH * 0.17, SCREEN_WIDTH * 0.04)];
    charmLabelOfSecond.text = @"999998";
    charmLabelOfSecond.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:charmLabelOfSecond];
    
    
    // 第三名
    UIImageView *thirdImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.71, SCREEN_WIDTH * 0.27 + 15, SCREEN_WIDTH * 0.24, SCREEN_WIDTH * 0.24)];
    thirdImage.image = [UIImage imageNamed:@"me_yp_no.3_"];
    [topView addSubview:thirdImage];
    
    UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.24, SCREEN_WIDTH * 0.24);
    [thirdImage addSubview:thirdButton];
    
    UILabel *nikenameLabelOfThird = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.73, SCREEN_WIDTH * 0.52 + 15, SCREEN_WIDTH * 0.21, SCREEN_WIDTH * 0.06)];
    nikenameLabelOfThird.text = @"班长";
    nikenameLabelOfThird.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:nikenameLabelOfThird];
    
    UILabel *charmLabelOfThird = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.75, SCREEN_WIDTH * 0.58 + 15, SCREEN_WIDTH * 0.17, SCREEN_WIDTH * 0.04)];
    charmLabelOfThird.text = @"999997";
    charmLabelOfThird.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:charmLabelOfThird];
    
    
    
}


#pragma mark - tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ElNormalListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalList];
    
    cell.listNumber = indexPath.row + 4;
    
    
    
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

