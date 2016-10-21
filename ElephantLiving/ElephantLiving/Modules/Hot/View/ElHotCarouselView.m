//
//  ElHotCarouselView.m
//  ElephantLiving
//
//  Created by dllo on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElHotCarouselView.h"
#import "ElHotCollectionViewCell.h"
static NSString *const carousel = @"carousel";

@interface ElHotCarouselView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UIScrollViewDelegate
>
@property (nonatomic, strong) UICollectionView *carouselView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *currentArray;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ElHotCarouselView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentArray = [NSMutableArray array];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, 100);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.carouselView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) collectionViewLayout:flowLayout];
        _carouselView.delegate = self;
        _carouselView.dataSource = self;
        _carouselView.pagingEnabled = YES;
        _carouselView.directionalLockEnabled = YES;
        _carouselView.showsHorizontalScrollIndicator = NO;
        _carouselView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_carouselView];
        
        [_carouselView registerClass:[ElHotCollectionViewCell class] forCellWithReuseIdentifier:carousel];

    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _currentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ElHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:carousel forIndexPath:indexPath];
    if (_currentArray.count > 0) {
        cell.coverImage = [UIImage imageNamed:_currentArray[indexPath.section]];
    }else {
        cell.coverImage = [UIImage imageNamed:@"me_yp_no.1_"];
    }
    return cell;
}

- (void)setImageArray:(NSArray *)imageArray {
    if (_imageArray != imageArray) {
        _imageArray = imageArray;
    }
    
    if (_currentArray.count > 0) {
        [_currentArray removeAllObjects];
    }
    if (_imageArray.count > 0) {
        [_currentArray addObject:[_imageArray lastObject]];
        [_currentArray addObjectsFromArray:_imageArray];
        [_currentArray addObject:[_imageArray firstObject]];
    }
    
    if (_timer) {
        [_timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    _pageControl.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.909 green:0.906 blue:0.907 alpha:0.393];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
    _pageControl.numberOfPages = _imageArray.count;
    CGSize pageSize = [_pageControl sizeForNumberOfPages:_imageArray.count];
    _pageControl.frame = CGRectMake(0, 0, pageSize.width, pageSize.height);
    _pageControl.center = CGPointMake(self.x + self.width -  _pageControl.width - 10, self.y +  self.height - _pageControl.height / 2 - 5);
    [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    _carouselView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
}

#pragma mark - 定时器

- (void)closeTimer {
    [_timer invalidate];
}

- (void)timeAction:(NSTimer *)sender {
    NSInteger pageNumber = _carouselView.contentOffset.x / SCREEN_WIDTH;
    if (_imageArray.count == pageNumber) {
        pageNumber = 0;
        [_carouselView setContentOffset:CGPointMake(pageNumber * SCREEN_WIDTH, 0) animated:NO];
    }
    [_carouselView setContentOffset:CGPointMake((pageNumber + 1) * SCREEN_WIDTH, 0) animated:YES];
    _pageControl.currentPage = pageNumber;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_carouselView]) {
        [_timer setFireDate:[NSDate distantPast]];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isEqual:_carouselView]) {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
    }
}

- (void)pageControlValueChanged:(UIPageControl *)pageControl {
    [_carouselView setContentOffset:CGPointMake((pageControl.currentPage + 1) * SCREEN_WIDTH, 0)];
}
#pragma mark - collectionView结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_carouselView]) {
        NSInteger pageCount = scrollView.contentOffset.x / SCREEN_WIDTH;
        if (0 == pageCount) {
            pageCount = _imageArray.count;
        }else if (_imageArray.count + 1 == pageCount) {
            pageCount = 1;
        }
        _pageControl.currentPage = pageCount - 1;
        [scrollView setContentOffset:CGPointMake(pageCount * SCREEN_WIDTH, 0) animated:YES];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
