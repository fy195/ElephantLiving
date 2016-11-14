//
//  NSString+ElAutoSize.m
//  ElephantLiving
//
//  Created by dllo on 16/11/10.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "NSString+ElAutoSize.h"

@implementation NSString (ElAutoSize)
- (CGFloat)cellHeight {
    CGSize infoSize = CGSizeMake(SCREEN_WIDTH - 70, 1000);
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:13.f]};
    
    // 计算文字高度
    // 参数1:自适应尺寸，提供一个宽度，去自适应高度
    // 参数2:自适应设置(以行为矩形区域自适应，以字体字形自适应)
    // 参数3:文字属性，通常这里面需要知道的是字体大小
    // 参数4:绘制文本上下文，做底层排版时使用，填nil即可
    CGRect infoRect = [self boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return ceil(infoRect.size.height);
}
@end
