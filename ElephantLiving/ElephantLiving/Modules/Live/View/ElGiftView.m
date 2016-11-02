//
//  ElGiftView.m
//  ElephantLiving
//
//  Created by Omaiga on 2016/11/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElGiftView.h"
#import "ElGiftCollectionViewCell.h"

static NSString *const string = @"cell";

@interface ElGiftView ()

<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@end

@implementation ElGiftView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 模糊效果
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:effectView];
        
        
        UICollectionViewFlowLayout *giftFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        giftFlowLayout.itemSize = CGSizeMake(self.frame.size.width / 3, (self.frame.size.height * 0.85) / 2);
        giftFlowLayout.minimumInteritemSpacing = 0;
        giftFlowLayout.minimumLineSpacing = 0;
        giftFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        UICollectionView *giftCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.85) collectionViewLayout:giftFlowLayout];
        giftCollectionView.backgroundColor = [UIColor clearColor];
        giftCollectionView.delegate = self;
        giftCollectionView.dataSource = self;
        giftCollectionView.contentSize = CGSizeMake(self.frame.size.width * 0.2, self.frame.size.height - 20);
        giftCollectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:giftCollectionView];
        
        self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.frame = CGRectMake(self.frame.size.width * 0.8, self.frame.size.height * 0.88, self.frame.size.width * 0.17, self.frame.size.height * 0.09);
        _sendButton.backgroundColor = [UIColor cyanColor];
        _sendButton.layer.cornerRadius = self.frame.size.height * 0.09 / 2;
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [self addSubview:_sendButton];
         
        
        // 注册
        [giftCollectionView registerClass:[ElGiftCollectionViewCell class] forCellWithReuseIdentifier:string];
        
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 11;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ElGiftCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:string forIndexPath:indexPath];
    
    if (0 == indexPath.item) {
        cell.giftImage = [UIImage imageNamed:@"gift_flower"];
        cell.priceText = @"2💎";
        cell.expericeText = @"+200经验";
        return cell;
    } else if (1 == indexPath.item) {
        cell.giftImage = [UIImage imageNamed:@"flower"];
        cell.priceText = @"2💎";
        cell.expericeText = @"+200经验";
        return cell;
    } else if (2 == indexPath.item) {
        cell.giftImage = [UIImage imageNamed:@"living_money_icon21"];
        cell.priceText = @"5💎";
        cell.expericeText = @"+500经验";
        return cell;
    } else if (3 == indexPath.item) {
        cell.giftImage = [UIImage imageNamed:@"car"];
        cell.priceText = @"1200💎";
        cell.expericeText = @"+12000经验";
        return cell;
    } else if (4 == indexPath.item) {
        cell.giftImage = [UIImage imageNamed:@"ferrari"];
        cell.priceText = @"1200💎";
        cell.expericeText = @"+12000经验";
        return cell;
    } else if (5 == indexPath.item) {
        cell.giftImage = [UIImage imageNamed:@"porsche_body"];
        cell.priceText = @"3000💎";
        cell.expericeText = @"+30000经验";
        return cell;
    }  else if (6 == indexPath.item) {
        cell.giftImage = [UIImage imageNamed:@"xinyiba_riva_Dolphin04"];
        cell.priceText = @"10💎";
        cell.expericeText = @"+1000经验";
        return cell;
    } else if (7 == indexPath.item) {
        cell.giftImage = [UIImage imageNamed:@"fireworks_11"];
        cell.priceText = @"888💎";
        cell.expericeText = @"+88800经验";
        return cell;
    } else if (8 == indexPath.item) {
        cell.giftImage = [UIImage imageNamed:@"gift_heart_20"];
        cell.priceText = @"888💎";
        cell.expericeText = @"+88800经验";
        return cell;
    } else if (9 == indexPath.item) {
        cell.giftImage = [UIImage imageNamed:@"test_6"];
        cell.priceText = @"10💎";
        cell.expericeText = @"+1000经验";
        return cell;
    } else if (10 == indexPath.item) {
        cell.giftImage = [UIImage imageNamed:@"18888_anima_img1"];
        cell.priceText = @"6666💎";
        cell.expericeText = @"+666600经验";
        return cell;
    }
    
    return cell;

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (0 == indexPath.item) {
        
    } else if (1 == indexPath.item) {
    
    } else if (2 == indexPath.item) {
        
    } else if (3 == indexPath.item) {
        
    } else if (4 == indexPath.item) {
        
    } else if (5 == indexPath.item) {
        
    } else if (6 == indexPath.item) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        [self addSubview:imageView];
        
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 1; i <= 7; i++) {
            NSString *imageName = [NSString stringWithFormat:@"xinyiba_riva_Dolphin0%d.png", i];
            UIImage *image = [UIImage imageNamed:imageName];
            [imageArray addObject:image];
        }
        
        imageView.animationImages = imageArray;
        imageView.animationDuration = 0.15 * imageArray.count;
        imageView.animationRepeatCount = 1;
        [imageView startAnimating];

    } else if (7 == indexPath.item) {
        
    } else if (8 == indexPath.item) {
        
    } else if (9 == indexPath.item) {
        
    } else if (10 == indexPath.item) {
        
    }
    
}

@end
