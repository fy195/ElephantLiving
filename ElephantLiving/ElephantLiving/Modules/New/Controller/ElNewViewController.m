//
//  ElNewViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElNewViewController.h"
#import "ElAVOSCloud.h"
#import "ElNewCollectionViewCell.h"
#import "ElLiveRoom.h"
#import "UIImageView+WebCache.h"
#import "ElWatchViewController.h"
#import "MJRefresh.h"

static NSString *const elNewViewCell = @"elNewViewCell";
@interface ElNewViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, strong) NSMutableArray *liveRoomArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ElNewViewController


- (void)viewDidLoad {
    self.liveRoomArray = [NSMutableArray array];
    [self searchLiving];
    [self createCollectionView];
}

- (void)searchLiving {
    AVQuery *query = [AVQuery queryWithClassName:@"ElLiveRoom"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            if (_liveRoomArray.count > 0) {
                [_liveRoomArray removeAllObjects];
            }
            
            [_liveRoomArray addObjectsFromArray:objects];
            [_collectionView reloadData];
        }
    }];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 3.1, SCREEN_WIDTH / 3.1);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    UINib *nib = [UINib nibWithNibName:@"ElNewCollectionViewCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:elNewViewCell];
    
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self searchLiving];
        [_collectionView.mj_header endRefreshing];
    }];
    _collectionView.mj_header.automaticallyChangeAlpha = YES;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _liveRoomArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ElLiveRoom *liveRoom = _liveRoomArray[indexPath.item];
    ElNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:elNewViewCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.name = liveRoom.host_name;
    cell.iconImage = liveRoom.headerImage;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ElLiveRoom *liveRoom = _liveRoomArray[indexPath.item];
    [self.delegate presentWatchControllerWithElLiveRoom:liveRoom];
}

@end
