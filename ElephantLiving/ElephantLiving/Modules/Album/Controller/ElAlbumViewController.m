//
//  ElAlbumViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElAlbumViewController.h"



@interface ElAlbumViewController ()
<
UITextViewDelegate
>
@end

@implementation ElAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 20)];
    topView.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1];
    [self.view addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    titleLabel.text = @"意见反馈";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:titleLabel];

    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.backgroundColor = [UIColor clearColor];
    returnButton.frame = CGRectMake(SCREEN_WIDTH * 0.02, SCREEN_WIDTH * 0.1, SCREEN_WIDTH * 0.09, SCREEN_WIDTH * 0.09);
    [returnButton setTitle:@"⇦" forState:UIControlStateNormal];
    returnButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    returnButton.centerY = titleLabel.centerY;
    [self.view addSubview:returnButton];
    
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.02, titleLabel.height + SCREEN_WIDTH * 0.02 + 20, SCREEN_WIDTH * 0.96, SCREEN_HEIGHT * 0.24)];
    [textView becomeFirstResponder];
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
    
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请尽量详细的描述您遇到的问题和现象,也欢迎对我们吐槽您不爽的地方,感谢您给我们提出宝贵的意见.";
    placeHolderLabel.font = [UIFont systemFontOfSize:15];
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, textView.height + textView.y + 20, SCREEN_WIDTH, SCREEN_HEIGHT * 0.05)];
    textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    textField.layer.borderWidth = 1;
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholder = @" 请留下您的手机号/邮箱/QQ号, 方便我们与您联系";
    
    [self.view addSubview:textField];
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, textField.y + textField.height + 30, SCREEN_WIDTH * 0.8, textField.height)];
    submitButton.backgroundColor = [UIColor colorWithRed:0.9843 green:0.4196 blue:0.0 alpha:1.0];
    submitButton.centerX = self.view.centerX;
    submitButton.layer.cornerRadius = textField.height / 2;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
    
    [submitButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
    if (textView.text.length > 0 && textField.text.length > 0 ) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提交成功" message:@"我们已经收到了,您的意见." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:^{
                }];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写您的意见或联系方式" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    }];
   
}
- (void)textViewDidChange:(UITextView *)textView {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;    //行间距
    paragraphStyle.maximumLineHeight = 20;   /**最大行高*/
    paragraphStyle.firstLineHeadIndent = 15.f;    /**首行缩进宽度*/
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
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
