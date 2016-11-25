//
//  ElLivingTopView.m
//  ElephantLiving
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElLivingTopView.h"
#import "UIImageView+WebCache.h"

@interface ElLivingTopView ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *watchCountLabel;                                                                             

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

- (void)setHeaderImage:(NSString *)headerImage {
    if (_headerImage != headerImage) {
        _headerImage = headerImage;
    }
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:headerImage]];
}

- (void)setWatchCount:(NSInteger )watchCount {
    if (_watchCount != watchCount) {
        _watchCount = watchCount;
    }
    _watchCountLabel.text = [NSString stringWithFormat:@"%ld人在观看", watchCount];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
