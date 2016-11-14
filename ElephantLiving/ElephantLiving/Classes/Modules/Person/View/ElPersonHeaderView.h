//
//  ElPersonHeaderView.h
//  ElephantLiving
//
//  Created by Omaiga on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElPersonHeaderView : UIView

@property (nonatomic, strong)UIImageView *backgroundImageView;

@property (nonatomic, strong)UIImage *backgroundImage;

@property (nonatomic, strong)UIImageView *headerImageView;

@property (nonatomic, strong)UIImage *headerImage;

@property (nonatomic, strong)UILabel *nikenameLabel;

@property (nonatomic, copy)NSString *nicknameText;

@property (nonatomic, strong)UILabel *gradeLabel;

@property (nonatomic, copy)NSString *gradeText;

@property (nonatomic, strong)UILabel *gradeNumberLabel;

@property (nonatomic, assign)NSInteger grade_count;

@property (nonatomic, strong)UILabel *viewLabel;

@property (nonatomic, copy)NSString *viewText;

@property (nonatomic, strong)UILabel *viewNumberLabel;

@property (nonatomic, assign)NSInteger view_count;

@property (nonatomic, strong)UILabel *followerLabel;

@property (nonatomic, copy)NSString *followerText;

@property (nonatomic, strong)UILabel *followerNumberLabel;

@property (nonatomic, assign)NSInteger follower_count;

@property (nonatomic, strong)UILabel *lineOfOneLabel;

@property (nonatomic, strong)UILabel *lineOfTwoLabel;

@end
