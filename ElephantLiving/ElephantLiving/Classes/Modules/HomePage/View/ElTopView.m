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
        self.underLine = [[UIView alloc] init];
        _underLine.frame = CGRectMake(0, self.height - 4, SCREEN_WIDTH * 0.15 + 20, 2);
        
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
    
    
    CGFloat height = self.height;
    
    
    _hotButton.width = SCREEN_WIDTH * 0.15;
    _hotButton.height = 20;
    _hotButton.y = (height + 20) / 2 - 10;
    _hotButton.x = SCREEN_WIDTH / 2 - _hotButton.width / 2;
    
    _newestButton.width = _hotButton.width;
    _newestButton.height = _hotButton.height;
    _newestButton.y = _hotButton.y;
    _newestButton.x = SCREEN_WIDTH / 4 - _newestButton.width / 2;
    
    _listButton.width = _hotButton.width;
    _listButton.height = _hotButton.height;
    _listButton.y = _hotButton.y;
    _listButton.x = SCREEN_WIDTH / 4 * 3 - _newestButton.width / 2;
    
    _underLine.centerX = self.centerX;
    
    
}

- (void)layoutMarginsDidChange {
    [super layoutMarginsDidChange];
}


- (UIButton *)createBtn:(NSString *)title {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
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
        self.underLine.x = btn.x - 20 * 0.5;
    }];
    

}

@end