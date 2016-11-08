//
//  ElSearchViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElSearchViewController.h"

#import "ElHomePageViewController.h"

#import "ElTopView.h"
#import "AVSearchQuery.h"
#import "ElSearchTableViewCell.h"
#import "_User.h"
#import "ElUserBriefView.h"
#import "ElReportViewController.h"

static NSString *const searchCell = @"searchCell";
@interface ElSearchViewController ()
<
UITextFieldDelegate,
UITableViewDataSource,
UITableViewDelegate,
ElUserBriefViewDelegate
>
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ElUserBriefView *userBriefView;
@property (nonatomic, strong) _User *selectedUser;
@end


@implementation ElSearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hahaha.jpeg"]];
    backView.frame = self.view.bounds;
    [self.view addSubview:backView];
    
    self.resultArray = [NSMutableArray array];
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 30, SCREEN_WIDTH * 0.8, 34)];
    _searchTextField.textColor = [UIColor whiteColor];
    _searchTextField.backgroundColor = [UIColor clearColor];
    _searchTextField.layer.borderColor = [[UIColor colorWithRed:0.9843 green:0.4196 blue:0.0 alpha:1.0] CGColor];
    _searchTextField.layer.borderWidth = 1;
    _searchTextField.layer.cornerRadius = 5;
    _searchTextField.clipsToBounds = YES;
    _searchTextField.delegate = self;
    _searchTextField.returnKeyType = UIReturnKeySearch;
    _searchTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    

    
    [self.view addSubview:_searchTextField];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setTitle:@"取消" forState:UIControlStateNormal];
    returnButton.frame = CGRectMake(_searchTextField.width + 5, _searchTextField.y  , SCREEN_WIDTH * 0.2 - 15, _searchTextField.height);
    returnButton.centerY = _searchTextField.centerY;
    [returnButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:returnButton];
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        self.tabBarController.tabBar.hidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 70, SCREEN_WIDTH - 10, SCREEN_HEIGHT - 30) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 50;
    _tableView.backgroundColor = [UIColor clearColor];
    UINib *nib = [UINib nibWithNibName:@"ElSearchTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:searchCell];
    [self.view addSubview:_tableView];
    
    self.userBriefView = [ElUserBriefView elUserBriefView];
    _userBriefView.frame = CGRectMake(SCREEN_WIDTH * 0.15, SCREEN_HEIGHT, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT * 0.45);
    _userBriefView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.85];
    _userBriefView.delegate = self;
    [self.view addSubview:_userBriefView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _User *user = _resultArray[indexPath.row];
    ElSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchCell];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.name = user.username;
    cell.headerImage = user.headImage;
    cell.level = user.level;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _User *currentUser = [_User currentUser];
    self.selectedUser = _resultArray[indexPath.row];
    _userBriefView.name = _selectedUser.username;
    _userBriefView.image = _selectedUser.headImage;
    _userBriefView.level = _selectedUser.level;
    _userBriefView.follower = _selectedUser.follower_count;
    _userBriefView.followee = _selectedUser.follow_count;
    [UIView animateWithDuration:0.5 delay:0.0f usingSpringWithDamping:0.7 initialSpringVelocity:-3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _userBriefView.frame = CGRectMake(SCREEN_WIDTH * 0.15, SCREEN_HEIGHT * 0.25, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT * 0.45);
    } completion:nil];
    [_selectedUser getFollowers:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        for (_User *user in objects) {
            if ([currentUser.objectId isEqualToString:user.objectId]) {
                [_userBriefView.followButton setTitle:@"已关注" forState:UIControlStateNormal];
                _userBriefView.isFollow = YES;
            }else {
                _userBriefView.isFollow = NO;
            }
        }
    }];
}

- (void)report {
    ElReportViewController *reportViewController = [[ElReportViewController alloc] init];
    [self.navigationController pushViewController:reportViewController animated:YES];
}

- (void)follow:(BOOL)isFollow {
    _User *currentUser = [_User currentUser];
    if (!isFollow) {
        [currentUser follow:_selectedUser.objectId andCallback:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded){
                currentUser.follow_count = [NSNumber numberWithInteger:[currentUser.follow_count integerValue] + 1];
                _selectedUser.follower_count = [NSNumber numberWithInteger:[_selectedUser.follower_count integerValue] + 1];
                [_userBriefView.followButton setTitle:@"已关注" forState:UIControlStateNormal];
                _userBriefView.isFollow = YES;
            }else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }else {
        [currentUser unfollow:_selectedUser.objectId andCallback:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                currentUser.follow_count = [NSNumber numberWithInteger:[currentUser.follow_count integerValue] - 1];
                _selectedUser.follower_count = [NSNumber numberWithInteger:[_selectedUser.follower_count integerValue] - 1];
                [_userBriefView.followButton setTitle:@"+ 关注" forState:UIControlStateNormal];
                _userBriefView.isFollow = NO;
            }else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    AVSearchQuery *searchQuery = [AVSearchQuery searchWithQueryString:[NSString stringWithFormat:@"%@", _searchTextField.text]];
    searchQuery.className = @"_User";
    searchQuery.highlights = [NSString stringWithFormat:@"%@", _searchTextField.text];
    searchQuery.limit = 10;
    searchQuery.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    searchQuery.maxCacheAge = 60;
    [searchQuery findInBackground:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            if (_resultArray.count > 0) {
                [_resultArray removeAllObjects];
            }
            [_resultArray addObjectsFromArray:objects];
            [_tableView reloadData];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    [_searchTextField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_searchTextField resignFirstResponder];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    //黑色
    //return UIStatusBarStyleDefault;
    //白色
    return UIStatusBarStyleLightContent;
}




@end
