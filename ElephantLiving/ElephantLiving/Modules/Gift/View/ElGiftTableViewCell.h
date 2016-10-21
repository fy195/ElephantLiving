//
//  ElGiftTableViewCell.h
//  ElephantLiving
//
//  Created by Omaiga on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElGiftTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *giftImageView;

@property (nonatomic, strong)UIImage *giftImage;

@property (nonatomic, strong)UILabel *giftNumberLabel;

@property (nonatomic, assign)NSInteger gift_count;

@end
