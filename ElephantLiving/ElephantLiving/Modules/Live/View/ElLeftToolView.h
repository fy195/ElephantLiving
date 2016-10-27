//
//  ElLeftToolView.h
//  象直播
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElLeftToolView : UIView
/**
 *  麦克风
 */
@property (weak, nonatomic) IBOutlet UIButton *microphoneButton;
/**
 *  音乐
 */
@property (weak, nonatomic) IBOutlet UIButton *musicButton;
/**
 *  摄像头
 */
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
/**
 *  闪光灯
 */
@property (weak, nonatomic) IBOutlet UIButton *flashlightButton;
/**
 *  @别人
 */
@property (weak, nonatomic) IBOutlet UIButton *atButton;

+ (instancetype)elLeftToolView;

@end
