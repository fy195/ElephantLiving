//
//  ElStartLiving.m
//  ElephantLiving
//
//  Created by Omaiga on 16/10/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElStartLiving.h"
#import "ElMacro.h"

@interface ElStartLiving ()

<
UITextFieldDelegate
>

@end

@implementation ElStartLiving

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.hidden = NO;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.15, SCREEN_HEIGHT * 0.3, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT * 0.1)];
        _nameTextField.textAlignment = NSTextAlignmentCenter;
        _nameTextField.textColor = [UIColor whiteColor];
        _nameTextField.font = [UIFont systemFontOfSize:25];
        _nameTextField.placeholder = @"给直播写个标题吧";
        _nameTextField.delegate = self;
        [self addSubview:_nameTextField];
        
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(SCREEN_WIDTH * 0.05, SCREEN_WIDTH * 0.1, SCREEN_WIDTH * 0.08, SCREEN_WIDTH * 0.08);
        [_backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [self addSubview:_backButton];
        
        
        self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _startButton.backgroundColor = [UIColor colorWithRed:0.9843 green:0.4196 blue:0.0 alpha:1.0];
        _startButton.frame = CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.75, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.07);
        [_startButton setTitle:@"开始直播" forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _startButton.layer.cornerRadius = 25;
        [self addSubview:_startButton];
        
        
        
    }
    return self;
}







- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    [UIView animateKeyframesWithDuration:0.2 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        _nameTextField.frame = CGRectMake(SCREEN_WIDTH * 0.15, SCREEN_HEIGHT * 0.2, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT * 0.1);
        _startButton.frame = CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.5, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.07);
        
    } completion:nil];
    return YES;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField endEditing:YES];
    
    [UIView animateKeyframesWithDuration:0.2 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        _nameTextField.frame = CGRectMake(SCREEN_WIDTH * 0.15, SCREEN_HEIGHT * 0.3, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT * 0.1);
        _startButton.frame = CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.75, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.07);
        
    } completion:nil];

    return YES;

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    
    [UIView animateKeyframesWithDuration:0.2 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModePaced animations:^{
        
        _nameTextField.frame = CGRectMake(SCREEN_WIDTH * 0.15, SCREEN_HEIGHT * 0.3, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT * 0.1);
        _startButton.frame = CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.75, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.07);
        
    } completion:nil];

    
    
    
}


@end
