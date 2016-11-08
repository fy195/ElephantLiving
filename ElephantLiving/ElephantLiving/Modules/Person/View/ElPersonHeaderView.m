//
//  ElPersonHeaderView.m
//  ElephantLiving
//
//  Created by Omaiga on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElPersonHeaderView.h"
#import "ElMacro.h"

@implementation ElPersonHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundImageView.backgroundColor = [UIColor colorWithRed:1.0 green:0.5441 blue:0.3207 alpha:1.0];
        [self addSubview:_backgroundImageView];
        
        
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width / 2 - self.bounds.size.height * 0.3 / 2), self.bounds.size.height * 0.3, self.bounds.size.height * 0.3, self.bounds.size.height * 0.3)];
        _headerImageView.image = [UIImage imageNamed:@"大象头像"];
        _headerImageView.layer.cornerRadius = _headerImageView.layer.cornerRadius = self.bounds.size.height * 0.3 / 2;
        _headerImageView.clipsToBounds = YES;
        [self addSubview:_headerImageView];
        
        
        self.nikenameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.35, self.bounds.size.height * 0.61, self.bounds.size.width * 0.3, self.bounds.size.width * 0.08)];
        _nikenameLabel.text = @"未知用户";
        _nikenameLabel.textAlignment = NSTextAlignmentCenter;
        _nikenameLabel.numberOfLines = 1;
        [self addSubview:_nikenameLabel];
        
        
        self.followerNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height * 0.81, self.bounds.size.width * 0.33, self.bounds.size.height * 0.08)];
        _followerNumberLabel.textColor = [UIColor lightGrayColor];
        _followerNumberLabel.text = @"0";
        _followerNumberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_followerNumberLabel];
        
        self.followerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height * 0.9, self.bounds.size.width * 0.33, self.bounds.size.height * 0.08)];
        _followerLabel.textAlignment = NSTextAlignmentCenter;
        _followerLabel.text = @"粉丝";
        _followerLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_followerLabel];
        
        
        self.lineOfOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.33, self.bounds.size.height * 0.8, 1, self.bounds.size.height * 0.17)];
        _lineOfOneLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_lineOfOneLabel];
        
        
        self.viewNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.335, self.bounds.size.height * 0.81, self.bounds.size.width * 0.33, self.bounds.size.height * 0.08)];
        _viewNumberLabel.textColor = [UIColor lightGrayColor];
        _viewNumberLabel.text = @"0";
        _viewNumberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_viewNumberLabel];
        
        self.viewLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.335, self.bounds.size.height * 0.9, self.bounds.size.width * 0.33, self.bounds.size.height * 0.08)];
        _viewLabel.textAlignment = NSTextAlignmentCenter;
        _viewLabel.text = @"关注";
        _viewLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_viewLabel];
        
        
        
        self.lineOfTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.665, self.bounds.size.height * 0.8, 1, self.bounds.size.height * 0.17)];
        _lineOfTwoLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_lineOfTwoLabel];

        
        self.gradeNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.67, self.bounds.size.height * 0.81, self.bounds.size.width * 0.33, self.bounds.size.height * 0.08)];
        _gradeNumberLabel.textColor = [UIColor lightGrayColor];
        _gradeNumberLabel.text = @"0";
        _gradeNumberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_gradeNumberLabel];
        
       
        
        self.gradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.67, self.bounds.size.height * 0.9, self.bounds.size.width * 0.33, self.bounds.size.height * 0.08)];
        _gradeLabel.textAlignment = NSTextAlignmentCenter;
        _gradeLabel.text = @"等级";
        _gradeLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_gradeLabel];
 
    }
    return self;
}


- (void)setBackgroundImage:(UIImage *)backgroundImage {
    if (_backgroundImage != backgroundImage) {
        _backgroundImage = backgroundImage;
        _backgroundImageView.image = backgroundImage;
    }
}


- (void)setHeaderImage:(UIImage *)headerImage {
    if (_headerImage != headerImage) {
        _headerImage = headerImage;
        _headerImageView.image = headerImage;
    }
}


- (void)setNicknameText:(NSString *)nicknameText {
    if (_nicknameText != nicknameText) {
        _nicknameText = nicknameText;
        _nikenameLabel.text = nicknameText;
    }
}


- (void)setViewText:(NSString *)viewText {
    if (_viewText != viewText) {
        _viewText = viewText;
        _viewNumberLabel.text = viewText;
    }
}

- (void)setFollowerText:(NSString *)followerText {
    if (_followerText != followerText) {
        _followerText = followerText;
        _followerLabel.text = followerText;
    }
}

- (void)setGradeText:(NSString *)gradeText {
    if (_gradeText != gradeText) {
        _gradeText = gradeText;
        _gradeNumberLabel.text = _gradeText;
    }
}
@end
