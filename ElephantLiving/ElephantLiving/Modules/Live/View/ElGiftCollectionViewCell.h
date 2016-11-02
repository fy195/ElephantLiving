//
//  ElGiftCollectionViewCell.h
//  ElephantLiving
//
//  Created by Omaiga on 2016/11/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElGiftCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView *giftImageView;

@property (nonatomic, strong)UIImage *giftImage;

@property (nonatomic, strong)UILabel *priceLabel;

@property (nonatomic, copy)NSString *priceText;

@property (nonatomic, strong)UIImageView *diamondImageView;

@property (nonatomic, strong)UIImage *diamondImage;

@property (nonatomic, strong)UILabel *experienceLabel;

@property (nonatomic, copy)NSString *expericeText;

@end
