//
//  ElHotCollectionViewCell.m
//  ElephantLiving
//
//  Created by dllo on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElHotCollectionViewCell.h"

@interface ElHotCollectionViewCell ()
@property (nonatomic, strong) UIImageView *coverImageView;
@end

@implementation ElHotCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_coverImageView];
    }
    return self;
}

- (void)setCoverImage:(UIImage *)coverImage {
    if (_coverImage != coverImage) {
        _coverImage = coverImage;
    }
    _coverImageView.image = coverImage;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _coverImageView.frame = CGRectMake(0, 0, self.width, self.height);
}

@end
