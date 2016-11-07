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
#import "LiveRoom.h"
#import "UIImageView+WebCache.h"

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

- (void)viewWillAppear:(BOOL)animated {
    [self searchLiving];
}

- (void)viewDidLoad {
    self.liveRoomArray = [NSMutableArray array];
    [self createCollectionView];
    [self searchLiving];
}

- (void)searchLiving {
    AVQuery *query = [AVQuery queryWithClassName:@"LiveRoom"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [_liveRoomArray addObjectsFromArray:objects];
    }];
    [_collectionView reloadData];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 3.0, SCREEN_WIDTH / 3.0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    UINib *nib = [UINib nibWithNibName:@"ElNewCollectionViewCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:elNewViewCell];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _liveRoomArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LiveRoom *liveRoom = _liveRoomArray[indexPath.item];
    ElNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:elNewViewCell forIndexPath:indexPath];
    
    cell.iconImage = liveRoom.coverImage;
    return cell;
}

@end
