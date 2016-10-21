//
//  ElGiftTableViewCell.m
//  ElephantLiving
//
//  Created by Omaiga on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElGiftTableViewCell.h"
#import "ElMacro.h"

@implementation ElGiftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 礼物图标
        self.giftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.03, SCREEN_WIDTH * 0.03, SCREEN_WIDTH * 0.15, SCREEN_WIDTH * 0.15)];
        _giftImageView.backgroundColor = [UIColor cyanColor];
        _giftImageView.image = [UIImage imageNamed:@"1.jpg"];
        _giftImageView.layer.cornerRadius = SCREEN_WIDTH * 0.15 / 2;
        [self addSubview:_giftImageView];
        
        // 礼物数
        self.giftNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.77, SCREEN_WIDTH * 0.07, SCREEN_WIDTH * 0.2, SCREEN_WIDTH * 0.08)];
        _giftNumberLabel.backgroundColor = [UIColor purpleColor];
        _giftNumberLabel.text = @"";
        _giftNumberLabel.textAlignment = NSTextAlignmentCenter;
        _giftNumberLabel.numberOfLines = 1;
        [self addSubview:_giftNumberLabel];
        
    }
    return self;
}


#pragma mark - set传值
- (void)setGiftImage:(UIImage *)giftImage {
    if (_giftImage != giftImage) {
        _giftImage = giftImage;
        _giftImageView.image = giftImage;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
