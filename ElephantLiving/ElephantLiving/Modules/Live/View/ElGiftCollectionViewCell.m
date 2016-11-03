//
//  ElGiftCollectionViewCell.m
//  ElephantLiving
//
//  Created by Omaiga on 2016/11/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElGiftCollectionViewCell.h"

@implementation ElGiftCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.giftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.2, self.frame.size.height * 0.2, self.frame.size.width * 0.6, self.frame.size.height * 0.4)];
        [self addSubview:_giftImageView];
        
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.15, self.frame.size.height * 0.7, self.frame.size.width * 0.7, self.frame.size.height * 0.15)];
        _priceLabel.text = @"";
        _priceLabel.textColor = [UIColor cyanColor];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_priceLabel];
        
        
        self.experienceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.15, self.frame.size.height * 0.85, self.frame.size.width * 0.7, self.frame.size.height * 0.15)];
        _experienceLabel.textAlignment = NSTextAlignmentCenter;
        _experienceLabel.text = @"";
        _experienceLabel.textColor = [UIColor lightGrayColor];
        _experienceLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_experienceLabel];
    }
    return self;
}


- (void)setGiftImage:(UIImage *)giftImage {
    if (_giftImage != giftImage) {
        _giftImage = giftImage;
        _giftImageView.image = giftImage;
    }
}

- (void)setPriceText:(NSString *)priceText {
    if (_priceText != priceText) {
        _priceText = priceText;
        _priceLabel.text = priceText;
    }
}

- (void)setExpericeText:(NSString *)expericeText {
    if (_expericeText != expericeText) {
        _expericeText = expericeText;
        _experienceLabel.text = expericeText;
    }
}
@end
