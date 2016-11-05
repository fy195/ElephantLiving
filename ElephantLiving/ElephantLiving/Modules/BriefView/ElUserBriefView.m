//
//  ElUserBriefView.m
//  ElephantLiving
//
//  Created by dllo on 16/11/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElUserBriefView.h"

@implementation ElUserBriefView

+ (instancetype)elUserBriefView {
    return [[NSBundle mainBundle] loadNibNamed:@"ElUserBriefView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
