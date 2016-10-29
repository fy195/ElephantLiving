//
//  ElTextViewController.h
//  ElephantLiving
//
//  Created by dllo on 16/10/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>

@interface ElTextViewController : UIViewController

@property (nonatomic, strong)AVUser *targetUser;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *codeButton;

@property (weak, nonatomic) IBOutlet UIButton *verifyButton;

@end
