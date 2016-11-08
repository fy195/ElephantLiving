//
//  ElUserBriefView.m
//  ElephantLiving
//
//  Created by dllo on 16/11/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElUserBriefView.h"
#import "UIImageView+WebCache.h"

@interface ElUserBriefView ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerLabel;
@property (weak, nonatomic) IBOutlet UILabel *followeeLabel;

@end

@implementation ElUserBriefView
                                 
+ (instancetype)elUserBriefView {
    return [[NSBundle mainBundle] loadNibNamed:@"ElUserBriefView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (IBAction)reportButtonAction:(id)sender {
    [self.delegate report];
}
- (IBAction)backButtonAction:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH * 0.15, SCREEN_HEIGHT, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT * 0.45);
    }];
}
- (IBAction)followButtonAction:(id)sender {
    [self.delegate follow:_isFollow];
}

- (void)setImage:(NSString *)image {
    if (_image != image) {
        _image = image;
    }
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:image]];
}

- (void)setName:(NSString *)name {
    if (_name != name) {
        _name = name;
    }
    _nameLabel.text = name;
}

- (void)setLevel:(NSNumber *)level {
    if (_level != level) {
        _level = level;
        _levelLabel.text = [NSString stringWithFormat:@"Level %@",level];
        _levelLabel.textColor = [UIColor colorWithRed:1.0 green:0.503 blue:0.0028 alpha:1.0];
    }
}

- (void)setLocation:(NSString *)location {
    if (_location != location) {
        _location = location;
    }
    _locationLabel.text = location;
}

- (void)setFollower:(NSNumber *)follower {
    if (_follower != follower) {
        _follower = follower;
    }
    _followerLabel.text = [NSString stringWithFormat:@"粉丝:%@",follower];
}

- (void)setFollowee:(NSString *)followee {
    if (_followee != followee) {
        _followee = followee;
    }
    _followerLabel.text = [NSString stringWithFormat:@"关注:%@", followee];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
