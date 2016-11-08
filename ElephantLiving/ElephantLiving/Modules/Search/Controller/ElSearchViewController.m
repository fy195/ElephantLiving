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

static NSString *const searchCell = @"searchCell";
@interface ElSearchViewController ()
<
UITextFieldDelegate,
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) UITableView *tableView;
@end


@implementation ElSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.resultArray = [NSMutableArray array];
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 30, SCREEN_WIDTH * 0.8, 34)];
    _searchTextField.backgroundColor = [UIColor whiteColor];
    _searchTextField.layer.borderColor = [[UIColor colorWithRed:0.9843 green:0.4196 blue:0.0 alpha:1.0] CGColor];
    _searchTextField.layer.borderWidth = 1;
    _searchTextField.layer.cornerRadius = 5;
    _searchTextField.clipsToBounds = YES;
    _searchTextField.delegate = self;
    _searchTextField.returnKeyType = UIReturnKeySearch;

    
    [self.view addSubview:_searchTextField];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setTitle:@"取消" forState:UIControlStateNormal];
    returnButton.frame = CGRectMake(_searchTextField.width + 5, _searchTextField.y  , SCREEN_WIDTH * 0.2 - 15, _searchTextField.height);
    returnButton.centerY = _searchTextField.centerY;
    [returnButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:returnButton];
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        self.tabBarController.tabBar.hidden = NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 70, SCREEN_WIDTH - 10, SCREEN_HEIGHT - 30) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 50;
    UINib *nib = [UINib nibWithNibName:@"ElSearchTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:searchCell];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _User *user = _resultArray[indexPath.row];
    ElSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchCell];
    cell.name = user.username;
    cell.headerImage = user.headImage;
    cell.level = user.level;
    return cell;
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






@end
