//
//  ElUserBriefView.m
//  ElephantLiving
//
//  Created by dllo on 16/11/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElUserBriefView.h"

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
    [self.delegate follow];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
