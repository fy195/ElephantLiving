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
 *  美颜
 */
@property (weak, nonatomic) IBOutlet UIButton *skinButton;
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
