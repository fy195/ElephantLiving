//
//  ElTopView.m
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElTopView.h"

@interface ElTopView ()

@end



@implementation ElTopView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.underLine = [[UIView alloc] initWithFrame:CGRectMake(15, self.height - 4, 70, 2)];
        _underLine.centerX = self.centerX;
        _underLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:_underLine];
        
        self.hotButton = [self createBtn:@"最热"];
        [self addSubview:_hotButton];
        
        self.newestButton = [self createBtn:@"最新"];
        [self addSubview:_newestButton];

       
        self.listButton = [self createBtn:@"榜单"];
        [self addSubview:_listButton];

        
        _hotButton.selected = YES;
        self.selectedBtn = _hotButton;
    
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _hotButton.centerX = SCREEN_WIDTH / 2;
    _hotButton.width = 60;
    _hotButton.height = 30;
    _hotButton.centerY =( self.height + 20 ) / 2;
    
    
    _newestButton.centerY = ( self.height + 20 ) / 2;
    _newestButton.centerX = SCREEN_WIDTH / 4;
    _newestButton.width = _hotButton.width;
    _newestButton.height = 30;
    
    _listButton.centerY = ( self.height + 20 ) / 2;
    _listButton.width = _hotButton.width;
    _listButton.centerX = SCREEN_WIDTH / 4 * 3;
    _listButton.height = 30;
}


- (UIButton *)createBtn:(NSString *)title {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return btn;

}
- (void)click:(UIButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.1f animations:^{
        self.underLine.x = btn.x - 10 * 0.5;
    }];
    

}

@end
