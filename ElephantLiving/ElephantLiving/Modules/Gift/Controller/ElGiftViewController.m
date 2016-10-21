//
//  ElGiftViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElGiftViewController.h"
#import "ElMacro.h"
#import "ElGiftTableViewCell.h"

static NSString *const giftOfCell = @"cell";

@interface ElGiftViewController ()

<
UITableViewDataSource,
UITableViewDelegate
>

@end

@implementation ElGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createGiftTableView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor yellowColor];
    backButton.frame = CGRectMake(0, 0, 64, 64);
    [backButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
}

#pragma mark - 返回按钮点击事件
- (void)buttonAction {

    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark - 创建礼物tableView
- (void)createGiftTableView {

    UITableView *giftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    giftTableView.rowHeight = 90;
    giftTableView.delegate = self;
    giftTableView.dataSource = self;
    [self.view addSubview:giftTableView];
    
    // 注册
    [giftTableView registerClass:[ElGiftTableViewCell class] forCellReuseIdentifier:giftOfCell];

}


#pragma mark - tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ElGiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:giftOfCell];
    
    
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
