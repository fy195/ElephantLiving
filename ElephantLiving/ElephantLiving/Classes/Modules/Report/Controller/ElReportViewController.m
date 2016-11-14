//
//  ElReportViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/11/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElReportViewController.h"

@interface ElReportViewController ()

@property (weak, nonatomic) IBOutlet UIButton *firstButton;

@property (weak, nonatomic) IBOutlet UIButton *secondButton;

@property (weak, nonatomic) IBOutlet UIButton *thirdButton;

@property (weak, nonatomic) IBOutlet UIButton *forthButton;

@property (weak, nonatomic) IBOutlet UIButton *fiveButton;

@end

@implementation ElReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createCheckButton];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)returnButton:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)reportButton:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"举报成功" message:@"我们将根据您的举报进行进一步的调查,如果符实我们将对该用户进行查封" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)createCheckButton {
    _firstButton.selected = NO;
    _secondButton.selected = NO;
    _thirdButton.selected = NO;
    _forthButton.selected = NO;
    _fiveButton.selected = NO;
    
    
    [_firstButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (_firstButton.selected == NO) {
            [_firstButton setImage:[UIImage imageNamed:@"选框选中"] forState:UIControlStateNormal];
            _firstButton.selected = YES;
        } else {
            [_firstButton setImage:[UIImage imageNamed:@"选框未选中"] forState:UIControlStateNormal];
            _firstButton.selected = NO;
        }
    }];
    
    [_secondButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (_secondButton.selected == NO) {
            [_secondButton setImage:[UIImage imageNamed:@"选框选中"] forState:UIControlStateNormal];
            _secondButton.selected = YES;
        } else {
            [_secondButton setImage:[UIImage imageNamed:@"选框未选中"] forState:UIControlStateNormal];
            _secondButton.selected = NO;
        }
    }];
    [_thirdButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (_thirdButton.selected == NO) {
            [_thirdButton setImage:[UIImage imageNamed:@"选框选中"] forState:UIControlStateNormal];
            _thirdButton.selected = YES;
        } else {
            [_thirdButton setImage:[UIImage imageNamed:@"选框未选中"] forState:UIControlStateNormal];
            _thirdButton.selected = NO;
        }
    }];
    [_forthButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (_forthButton.selected == NO) {
            [_forthButton setImage:[UIImage imageNamed:@"选框选中"] forState:UIControlStateNormal];
            _forthButton.selected = YES;
        } else {
            [_forthButton setImage:[UIImage imageNamed:@"选框未选中"] forState:UIControlStateNormal];
            _forthButton.selected = NO;
        }
    }];
    [_fiveButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (_fiveButton.selected == NO) {
            [_fiveButton setImage:[UIImage imageNamed:@"选框选中"] forState:UIControlStateNormal];
            _fiveButton.selected = YES;
        } else {
            [_fiveButton setImage:[UIImage imageNamed:@"选框未选中"] forState:UIControlStateNormal];
            _fiveButton.selected = NO;
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
