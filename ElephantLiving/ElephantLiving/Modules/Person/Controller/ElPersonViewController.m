//
//  ElPersonViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElPersonViewController.h"
#import "ElPersonHeaderView.h"
#import "ElPersonTableViewCell.h"
#import "ElPersonCharmTableViewCell.h"
#import "ElGiftViewController.h"
#import "ElAlbumViewController.h"
#import "ElManageViewController.h"
#import "ElSettingViewController.h"

static NSString *const person = @"person";
static NSString *const charm = @"charm";

@interface ElPersonViewController()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation ElPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"ElPersonTableViewCell" bundle:nil];
    UINib *charmNib = [UINib nibWithNibName:@"ElPersonCharmTableViewCell" bundle:nil];
    self.titleArray = @[@[@"魅力值", @"收到的礼物", @"送出的礼物"], @[@"相册", @"直播间管理"], @[@"设置"]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 60;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:cellNib forCellReuseIdentifier:person];
    [_tableView registerNib:charmNib forCellReuseIdentifier:charm];
    
    ElPersonHeaderView *headerView = [[ElPersonHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.45)];
    _tableView.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    footerView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    _tableView.tableFooterView = footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = _titleArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = _titleArray[indexPath.section];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ElPersonCharmTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:charm];
            cell.title = array[indexPath.row];
            cell.count = [NSString stringWithFormat:@"%ld", (NSInteger)9999];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    ElPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:person];
    cell.title = array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        if (indexPath.row > 0) {
            ElGiftViewController *giftViewController = [[ElGiftViewController alloc] init];
            [self presentViewController:giftViewController animated:YES completion:nil];
        }
    }else if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            ElAlbumViewController *albumViewController = [[ElAlbumViewController alloc] init];
            [self presentViewController:albumViewController animated:YES completion:nil];
        }else {
            ElManageViewController *manageViewController = [[ElManageViewController alloc] init];
            [self presentViewController:manageViewController animated:YES completion:nil];
        }
    }else {
        ElSettingViewController *settingViewController = [[ElSettingViewController alloc] init];
        [self.navigationController pushViewController:settingViewController animated:YES];
    }
}

@end
