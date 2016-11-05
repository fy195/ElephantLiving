//
//  ElLivingTopView.m
//  ElephantLiving
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElLivingTopView.h"

@interface ElLivingTopView ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *watchCountLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *headerScrollView;

@end

@implementation ElLivingTopView

+(instancetype)elLivingTopView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerImageView.layer.borderWidth = 1.0f;
    self.headerImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _headerImageView.userInteractionEnabled = YES;
    _headerImageView.image = [UIImage imageNamed:@"大象头像"];
}

- (IBAction)imageButtonAction:(id)sender {
    [self.delegate presentBriefView];
}

- (void)setHeaderImage:(UIImage *)headerImage {
    if (_headerImage != headerImage) {
        _headerImage = headerImage;
    }
    _headerImageView.image = headerImage;
}

- (void)setWatchCount:(NSNumber *)watchCount {
    if (_watchCount != watchCount) {
        _watchCount = watchCount;
    }
    _watchCountLabel.text = [NSString stringWithFormat:@"%@人在观看", watchCount];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
