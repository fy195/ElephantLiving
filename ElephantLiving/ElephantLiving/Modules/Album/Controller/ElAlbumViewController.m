//
//  ElAlbumViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElAlbumViewController.h"
#import "ElMacro.h"
#import "ElAlbumCollectionViewCell.h"

static NSString *const albumCell = @"cell";
static NSString *const header = @"headerCell";

@interface ElAlbumViewController ()

<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@end

@implementation ElAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createAlbumCollectionView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor yellowColor];
    backButton.frame = CGRectMake(0, 0, 64, 64);
    [backButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
}

#pragma mark - 创建相册collectionView
- (void)createAlbumCollectionView {

    UICollectionViewFlowLayout *albumFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    albumFlowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - SCREEN_WIDTH * 0.015) / 4, ((SCREEN_WIDTH - SCREEN_WIDTH * 0.015) / 4) / 9 * 10);
    albumFlowLayout.minimumInteritemSpacing = 0;
    albumFlowLayout.minimumLineSpacing = 2;
    albumFlowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50);
    
    
    UICollectionView *albumCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:albumFlowLayout];
    albumCollectionView.backgroundColor = [UIColor whiteColor];
    albumCollectionView.delegate = self;
    albumCollectionView.dataSource = self;
    [self.view addSubview:albumCollectionView];
    
    // 注册
    [albumCollectionView registerClass:[ElAlbumCollectionViewCell class] forCellWithReuseIdentifier:albumCell];
    
    [albumCollectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header];
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *timeArray = @[@"2016年10月19日", @"2016年10月20日", @"2016年10月21日"];

    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.03, SCREEN_WIDTH * 0.05, SCREEN_WIDTH, SCREEN_WIDTH * 0.06)];
    headerLabel.text = timeArray[indexPath.section];
    [headerView addSubview:headerLabel];
    
    return headerView;

}

#pragma mark - 返回按钮点击事件
- (void)buttonAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - collectionView协议方
// 设置区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 3;
}

// 返回item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (0 == section) {
        return 3;
    } else if (1 == section) {
    
        return 9;
        
    }
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ElAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:albumCell forIndexPath:indexPath];
    
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
