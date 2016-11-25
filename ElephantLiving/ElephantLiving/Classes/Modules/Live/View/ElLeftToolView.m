//
//  ElLeftToolView.m
//  象直播
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "ElLeftToolView.h"

@implementation ElLeftToolView

+ (instancetype)elLeftToolView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}





@end
