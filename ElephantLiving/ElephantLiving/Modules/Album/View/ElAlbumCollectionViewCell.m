//
//  ElAlbumCollectionViewCell.m
//  ElephantLiving
//
//  Created by Omaiga on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElAlbumCollectionViewCell.h"

@implementation ElAlbumCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.albumImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _albumImageView.backgroundColor = [UIColor cyanColor];
        _albumImageView.image = [UIImage imageNamed:@"1.jpg"];
        [self addSubview:_albumImageView];
    
    }
    return self;
}


- (void)setAlbumImage:(UIImage *)albumImage {
    if (_albumImage != albumImage) {
        _albumImage = albumImage;
        _albumImageView.image = albumImage;
    }
}

@end
