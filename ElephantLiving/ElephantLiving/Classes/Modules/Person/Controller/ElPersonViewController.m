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
#import "ElAlbumViewController.h"
#import "ElSettingViewController.h"
#import "_User.h"
#import "UIImage+Categories.h"
#import "ElForgetPasswordViewController.h"
#import "ElChangeNicknameViewController.h"

static NSString *const person = @"person";
static NSString *const charm = @"charm";

@interface ElPersonViewController()
<
UITableViewDelegate,
UITableViewDataSource,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) _User *currentUserInfo;

@property (nonatomic, strong) ElPersonHeaderView *headerView;

@end

@implementation ElPersonViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getCurrentUserInfo];
    _headerView.nicknameText = [_currentUserInfo username];
    AVFile *file = [AVFile fileWithURL:_currentUserInfo.headImage];
    [file getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
        if (!error) {
            _headerView.headerImage = image;
            UIImage *blurImage = [image boxblurImageWithBlur:0.7];
            _headerView.backgroundImage = blurImage;
        }else {
        }
    }];
    _headerView.headerImageView.userInteractionEnabled = YES;
    [_tableView reloadData];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    //黑色
    //return UIStatusBarStyleDefault;
    //白色
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 状态栏颜色
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    statusBarView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:statusBarView];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [self getCurrentUserInfo];
    [self createTableView];
}

- (void)getCurrentUserInfo{
    self.currentUserInfo = [_User currentUser];
}

- (void)createTableView {
    
    UINib *cellNib = [UINib nibWithNibName:@"ElPersonTableViewCell" bundle:nil];
    UINib *charmNib = [UINib nibWithNibName:@"ElPersonCharmTableViewCell" bundle:nil];
    self.titleArray = @[@[@"魅力值", @"修改昵称", @"修改密码"], @[@"意见反馈"], @[@"设置"]];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 60;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:cellNib forCellReuseIdentifier:person];
    [_tableView registerNib:charmNib forCellReuseIdentifier:charm];
    
    

    self.headerView = [[ElPersonHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.45)];
    _tableView.tableHeaderView = _headerView;
    
    _headerView.nicknameText = [_currentUserInfo username];
    _headerView.followerNumberLabel.text = [NSString stringWithFormat:@"%@",[_currentUserInfo follower_count]];
    _headerView.gradeNumberLabel.text = [NSString stringWithFormat:@"%@",[_currentUserInfo level]];
    _headerView.viewNumberLabel.text = [NSString stringWithFormat:@"%@",[_currentUserInfo follow_count]];
    

    AVFile *file = [AVFile fileWithURL:_currentUserInfo.headImage];
    [file getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
        if (!error) {
            _headerView.headerImage = image;
//            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//            effectView.frame = CGRectMake(0, 0, bgImgView.frame.size.width*0.5, bgImgView.frame.size.height);
            _headerView.backgroundImage = [image boxblurImageWithBlur:0.7];
        }else {}
    }];
    _headerView.headerImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alterHeadImageAction:)];
    [_headerView.headerImageView addGestureRecognizer:singleTap];
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    footerView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    _tableView.tableFooterView = footerView;

}



- (void)alterHeadImageAction:(UITapGestureRecognizer *)gesture {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSData *data = UIImagePNGRepresentation(newPhoto);
    
    AVFile *file = [AVFile fileWithName:@"headImage.png" data:data];
    
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            _User *user = [_User currentUser];
            user.headImage = file.url;
            [user saveInBackground];
            
            AVFile *file = [AVFile fileWithURL:user.headImage];
            [file getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
                if (!error) {
                    _headerView.headerImage = image;
                    UIImage *blurImage = [image boxblurImageWithBlur:0.7];
                    _headerView.backgroundImage = blurImage;
                }else {
                    //NSLog(@"%@",error);
                }
            }];
        } else {
            //NSLog(@"%@",error);
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
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
            cell.count = [NSString stringWithFormat:@"%ld", [_currentUserInfo charm]];
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
        if (indexPath.row == 1) {
            ElChangeNicknameViewController *changeNicknameViewController = [[ElChangeNicknameViewController alloc] init];
            [self.navigationController pushViewController:changeNicknameViewController animated:YES];
        } else if (indexPath.row == 2){
            ElForgetPasswordViewController *forgetPasswordViewController = [[ElForgetPasswordViewController alloc] init];
            [self.navigationController pushViewController:forgetPasswordViewController animated:YES];
        }
    }else if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            ElAlbumViewController *albumViewController = [[ElAlbumViewController alloc] init];
            [self.navigationController pushViewController:albumViewController animated:YES];
        }else {
        }
    }else {
        ElSettingViewController *settingViewController = [[ElSettingViewController alloc] init];
        [self.navigationController pushViewController:settingViewController animated:YES];
    }
}

@end
