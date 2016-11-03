//
//  ElLiveViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElLiveViewController.h"
#import "ElStartLiving.h"
#import <QPLive/QPLive.h>
#import "ElLeftToolView.h"
#import "ElLivingTopView.h"
#import "ElLivingBottomToolView.h"
#import "ElEndLiving.h"
#import "AVOSCloudIM.h"
#import "AVIMConversation.h"
#import "ElGiftView.h"
#import "ElLivingRoom.h"
#import "ElUser.h"
#import "PresentView.h"
#import "GiftModel.h"
#import "AnimOperation.h"
#import "AnimOperationManager.h"
#import "GSPChatMessage.h"
#import "ElHeartAnimationView.h"
#import "ElCarAnimationView.h"
#import "ElCarTwoAnimationView.h"
#import "ElCarThreeAnimationView.h"
#import "ElCarFourAnimationView.h"
#import "ElDolphinAnimationView.h"
#import "ElFireworksAnimationView.h"
#import "ElHouseAniamtionView.h"


NSInteger i = 1;
@interface ElLiveViewController ()
<
QPLiveSessionDelegate,
AVIMClientDelegate,
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource,
ElGiftViewDelegate
>
@property (nonatomic, strong) ElLivingRoom *liveRoom;
@property (nonatomic, strong) ElStartLiving *startView;
@property (nonatomic, strong) UIImageView *timeImageView;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, assign) NSInteger timeNumber;
@property (nonatomic, strong) NSString *pushUrl;
@property (nonatomic, strong) NSString *pullUrl;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) ElLeftToolView *leftToolView;
@property (nonatomic, strong) ElLivingTopView *topToolView;
@property (nonatomic, strong) ElLivingBottomToolView *bottomToolView;
@property (nonatomic, strong) ElEndLiving *endView;
@property (nonatomic, strong) QPLiveSession *liveSession;;
@property (nonatomic, strong) QPLConfiguration *configuration;
@property (nonatomic, strong) NSString *timeString;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *keyboardView;
@property (nonatomic, strong) UIButton *keyboardButton;
@property (nonatomic, strong) UITableView *commentTableView;
@property (nonatomic, retain) NSMutableArray *messageArray;
@property (nonatomic, strong) AVIMClient *client;
@property (nonatomic, strong) AVIMConversation *currentConversation;
@property (nonatomic, strong) ElGiftView *giftView;
@property (nonatomic, strong) NSMutableArray *animationImageViews;

@end

@implementation ElLiveViewController{
    QPLiveSession *_liveSession;
    AVCaptureDevicePosition _currentPosition;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    _startView.hidden = NO;
    [self hiddenToolView:YES];
    _endView.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (NSMutableArray *)animationImageViews {
    if (nil == _animationImageViews) {
        _animationImageViews = [NSMutableArray array];
    }
    return _animationImageViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.messageArray = [NSMutableArray array];
    
    self.startView = [[ElStartLiving alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_startView];
    [_startView.startButton addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_startView.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self createToolView];
    
    self.timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _timeImageView.center = self.view.center;
    _timeImageView.backgroundColor = [UIColor   clearColor];
    
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
//    [self.view addGestureRecognizer:gesture];
    
    [self createRequest];
    [self createConfiguration];
    
}

// 创建工具栏
- (void)createToolView {
    [self createKeyboardView];
    
    // 结束画面
    self.endView = [[ElEndLiving alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_endView.backButton addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_endView];
    
    // 顶部工具栏
    self.topToolView = [ElLivingTopView elLivingTopView];
    _topToolView.frame = CGRectMake(0, 20, SCREEN_WIDTH, 57);
    _topToolView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_topToolView];
    
    // 左侧工具栏
    self.leftToolView = [ElLeftToolView elLeftToolView];
    _leftToolView.frame = CGRectMake(0, _topToolView.y + _topToolView.height, 50, 230);
    _leftToolView.backgroundColor = [UIColor clearColor];
    [_leftToolView.cameraButton addTarget:self action:@selector(cameraButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_leftToolView.skinButton addTarget:self action:@selector(skinButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_leftToolView.flashlightButton addTarget:self action:@selector(flashButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftToolView];
    
    // 底部工具栏
    self.bottomToolView = [ElLivingBottomToolView elLivingBottomToolView];
    _bottomToolView.frame = CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70);
    _bottomToolView.backgroundColor = [UIColor clearColor];
    [_bottomToolView.commentButton addTarget:self action:@selector(commentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomToolView.giftButton addTarget:self action:@selector(giftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.giftView = [[ElGiftView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4)];
    [self.view addSubview:_giftView];
    _giftView.delegate = self;

    [self.view addSubview:_bottomToolView];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.frame = CGRectMake(SCREEN_WIDTH - 22 - 30, SCREEN_HEIGHT - 20 - 30, 30, 30);
    _closeButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
    _closeButton.layer.cornerRadius = 15.0;
    _closeButton.clipsToBounds = YES;
    [_closeButton setBackgroundImage:[UIImage imageNamed:@"Home"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeButton];
    [self.view bringSubviewToFront:_closeButton];
    [self createCommentTableView];
    
    [self hiddenToolView:YES];
}

// 创建tableView
- (void)createCommentTableView {
    self.commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 270, SCREEN_WIDTH - 70, 200) style:UITableViewStylePlain];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.backgroundColor = [UIColor clearColor];
    _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_commentTableView];
    [self.view bringSubviewToFront:_commentTableView];
    
    self.client = [AVIMClient defaultClient];
    _client.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _messageArray[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithWhite:0.900 alpha:1.000];
    NSRange range = [_messageArray[indexPath.row] rangeOfString:@":"];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_messageArray[indexPath.row]]];
    NSRange range1 = NSMakeRange(0, range.location + 1);
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.000 green:0.559 blue:0.224 alpha:1.000] range:range1];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range1];
    [cell.textLabel setAttributedText:str];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.backgroundColor = [UIColor clearColor];
    [cell.textLabel sizeToFit];
    return cell;
}

- (void)addMessage {
    AVIMMessageOption *option = [[AVIMMessageOption alloc] init];
    option.receipt = YES;
    AVIMTextMessage *textMessage = [AVIMTextMessage messageWithText:_textField.text attributes:nil];
    [_currentConversation sendMessage:textMessage option:option callback:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            [_messageArray addObject:[NSString stringWithFormat:@"%@: %@", textMessage.clientId, textMessage.text]];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_messageArray.count - 1 inSection:0];
            [_commentTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [_commentTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        }
    }];
}

// 创建输入框
- (void)createKeyboardView {
    self.keyboardView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 50)];
    _keyboardView.userInteractionEnabled = YES;
    _keyboardView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.50];
    [self.view addSubview:_keyboardView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideAction:) name:UIKeyboardWillHideNotification object:nil];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH - 20 - 80, 30)];
    _textField.delegate = self;
    _textField.placeholder = @"和大家说点什么";
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.clearsOnBeginEditing = YES;
    _textField.keyboardType = UIKeyboardTypeNamePhonePad;
    [_keyboardView addSubview:_textField];
    
    self.keyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _keyboardButton.frame = CGRectMake(_textField.x + _textField.width + 10, 10, 50, 30);
    [_keyboardView addSubview:_keyboardButton];
    [_keyboardButton setTitle:@"发送" forState:UIControlStateNormal];
    [_keyboardButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _keyboardButton.backgroundColor = [UIColor clearColor];
    _keyboardButton.layer.borderWidth = 1.0f;
    _keyboardButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _keyboardButton.clipsToBounds = YES;
    _keyboardButton.layer.cornerRadius = 7.0;
    [_keyboardButton addTarget:self action:@selector(keyboardButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

// 主播结束直播按钮
- (void)closeButtonAction:(UIButton *)button {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定结束直播吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [_client openWithCallback:^(BOOL succeeded, NSError * _Nullable error) {
//            AVIMConversationQuery *query = [self.client conversationQuery];
//            [query whereKey:AVIMAttr(@"topic") equalTo:_liveRoom.objectId];
//            [query whereKey:@"tr" equalTo:@(YES)];
//            [query findConversationsWithCallback:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//                [objects.lastObject deleteInBackground];
//                NSLog(@"删除聊天室成功");
//            }];
//        }];
        [_liveRoom deleteInBackground];
        [_liveSession disconnectServer];
        [_liveSession stopPreview];
        _endView.hidden = NO;        
        [self timeEnd];
        _endView.timeLabel.text = _timeString;
        [self hiddenToolView:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancelAction];
    [alert addAction:commitAction];
    [self presentViewController:alert animated:YES completion:nil];
}

// 隐藏工具栏
- (void)hiddenToolView:(BOOL)isLiving {
    if (isLiving) {
        _commentTableView.hidden = YES;
        _topToolView.hidden = YES;
        _leftToolView.hidden = YES;
        _bottomToolView.hidden = YES;
        _closeButton.hidden = YES;
    }else {
        _commentTableView.hidden = NO;
        _topToolView.hidden = NO;
        _leftToolView.hidden = NO;
        _bottomToolView.hidden = NO;
        _closeButton.hidden = NO;
    }
}

// 聚焦
//- (void)tapGesture:(UITapGestureRecognizer *)gesture{
//    CGPoint point = [gesture locationInView:self.view];
//    CGPoint percentPoint = CGPointZero;
//    percentPoint.x = point.x / CGRectGetWidth(self.view.bounds);
//    percentPoint.y = point.y / CGRectGetHeight(self.view.bounds);
//    [_liveSession focusAtAdjustedPoint:percentPoint autoFocus:YES];
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        _giftView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4);
//    }];
//}

// 请求推拉流地址
- (void)createRequest {
    QPLiveRequest *request = [[QPLiveRequest alloc] init];
    [request requestCreateLiveWithDomain:kELDomain success:^(NSString *pushUrl, NSString *pullUrl) {
        self.pushUrl = pushUrl;
        _configuration.url = pushUrl;
        self.pullUrl = pullUrl;
    } failure:^(NSError *error) {
        UIAlertController *alerat = [UIAlertController alertControllerWithTitle:@"" message:@"Create Live Failed" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alerat addAction:action];
        [self presentViewController:alerat animated:YES completion:nil];
    }];
}

// 视频参数
- (void)createConfiguration {
    QPLConfiguration *configuration = [[QPLConfiguration alloc] init];
    configuration.url = _pushUrl;
    configuration.videoMaxBitRate = 400 * 1000;
    configuration.videoBitRate = 400 * 1000;
    configuration.videoMinBitRate = 400 * 1000;
    configuration.audioBitRate = 64 * 1000;
    configuration.videoSize = CGSizeMake(360, 640);// 横屏状态宽高不需要互换
    configuration.fps = 20;
    configuration.preset = AVCaptureSessionPresetiFrame1280x720;
    configuration.screenOrientation = 0;
    self.configuration = configuration;
    
    // 水印
    configuration.waterMaskImage = [UIImage imageNamed:@"水印"];
    configuration.waterMaskLocation = 0;
    configuration.waterMaskMarginX = 20;
    configuration.waterMaskMarginY = 20;
    
    if (_currentPosition) {
        configuration.position = _currentPosition;
    }else {
        configuration.position = AVCaptureDevicePositionFront;
        _currentPosition = AVCaptureDevicePositionFront;
    }
    
    self.liveSession = [[QPLiveSession alloc] initWithConfiguration:configuration];
    _liveSession.delegate = self;
    [_liveSession startPreview];
    [_liveSession setEnableSkin:YES];
    [_liveSession updateConfiguration:^(QPLConfiguration *configuration) {
        configuration.videoMaxBitRate = 400 * 1000;
        configuration.videoBitRate = 400 * 1000;
        configuration.videoMinBitRate = 400 * 1000;
        configuration.audioBitRate = 64 * 1000;
        configuration.fps = 20;
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view insertSubview:[_liveSession previewView] atIndex:0];
    });
}

// 开始直播按钮
- (void)startButtonAction:(UIButton *)startButton {
    _startView.hidden = YES;
    [self.view addSubview:_timeImageView];
    [self openCountdown];
    [self hiddenToolView:NO];
}

// 未开始直播时的关闭按钮
- (void)backButtonAction:(UIButton *)backButton {
    [_liveSession stopPreview];
    [_liveSession.previewView removeFromSuperview];
    CATransition* transition = [CATransition animation];
    //执行时间长短
    transition.duration = 0.5;
    //动画的开始与结束的快慢
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //各种动画效果
    transition.type = kCATransitionPush; //kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //动画方向
    transition.subtype = kCATransitionFromBottom;
    //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    //将动画添加在视图层上
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

// 开始直播后结束直播的返回按钮
- (void)backHomeAction:(UIButton *)button {
    [_liveSession.previewView removeFromSuperview];
    _liveSession = nil;
    [self.navigationController popViewControllerAnimated:NO];
}

// 开始倒计时
-(void)openCountdown{
    
    __block NSInteger time = 3; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self countdownEnd];
                //  创建直播间对象
                [self creatLiveRoom];
                [self createChatRoom];
                // 倒计时结束开始连接服务直播计时
                [_liveSession connectServer];
                
            });
        }else{
            int seconds = time % 4;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self inTheCountdown:seconds];
                
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

//  倒计时结束
- (void)countdownEnd {
    [_timeImageView removeFromSuperview];
    self.timeNumber = 0;
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

//  倒计时中
- (void)inTheCountdown: (int)seconds {

    _timeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"time%d",seconds]];
    [UIView animateWithDuration:0.8 animations:^{
        _timeImageView.frame = CGRectMake(0, 0, 200, 200);
        _timeImageView.center = self.view.center;
        _timeImageView.alpha = 1;
    } completion:^(BOOL finished) {
        _timeImageView.frame = CGRectMake(0, 0, 10, 10);
        _timeImageView.center = self.view.center;
        _timeImageView.alpha = 0.5;
    }];
    
}

- (void) timerAction {
    _timeNumber++;
}

//  直播时长
- (void)timeEnd {
    [_myTimer invalidate];
    NSInteger tempHour = _timeNumber / 3600;
    NSInteger tempMinute = _timeNumber / 60 - (tempHour * 60);
    NSInteger tempSecond = _timeNumber - (tempHour * 3600 + tempMinute * 60);
    NSString *hour = [[NSNumber numberWithInteger:tempHour] stringValue];
    NSString *minute = [[NSNumber numberWithInteger:tempMinute] stringValue];
    NSString *second = [[NSNumber numberWithInteger:tempSecond] stringValue];
    if (tempHour < 10) {
        hour = [@"0" stringByAppendingString:hour];
    }
    if (tempMinute < 10) {
        minute = [@"0" stringByAppendingString:minute];
    }
    if (tempSecond < 10) {
        second = [@"0" stringByAppendingString:second];
    }
    self.timeString = [NSString stringWithFormat:@"%@:%@:%@",hour,minute,second];
    
}

// 创建直播间
- (void)creatLiveRoom {

    ElUser *currentUser = [ElUser currentUser];
    self.liveRoom = [ElLivingRoom objectWithClassName:@"LiveRoom"];
    /**
     *  拉流地址
     */
    _liveRoom.pullUrl = _pullUrl;
    /**
     *  主播名称
     */
    _liveRoom.host_name = currentUser.username;
    /**
     *  观看人数
     */
    _liveRoom.view_count = @0;
    /**
     *  直播间标题
     */
    _liveRoom.liveRoom_title = _startView.nameTextField.text;
    [_liveRoom saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"保存成功");
        } else {
            NSLog(@"创建对象出错 %@", error);
        }
    }];
}

// 创建聊天室
- (void)createChatRoom {
    AVUser *user = [AVUser currentUser];
    self.client = [[AVIMClient alloc] initWithClientId:user.username];
    _client.delegate = self;
    [_client openWithCallback:^(BOOL succeeded, NSError * _Nullable error) {
        NSString *topic = _liveRoom.objectId;
        NSDictionary *dic = @{@"topic":topic};
        [_client createConversationWithName:topic clientIds:@[] attributes:dic options:AVIMConversationOptionTransient callback:^(AVIMConversation * _Nullable conversation, NSError * _Nullable error) {
            if (!error) {
                self.currentConversation = conversation;
            }
        }];
    }];
}

// session代理方法
- (void)liveSession:(QPLiveSession *)session error:(NSError *)error{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *msg = [NSString stringWithFormat:@"%zd %@",error.code, error.localizedDescription];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Live Error" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新连接", nil];
        alertView.delegate = self;
        [alertView show];
    });
}

- (void)liveSessionNetworkSlow:(QPLiveSession *)session{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络太差" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    });
}

// 左侧工具栏按钮
- (void)cameraButtonClick:(UIButton *)button {
    button.selected = !button.isSelected;
    _liveSession.devicePosition = button.isSelected ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
    _currentPosition = _liveSession.devicePosition;
}

- (void)skinButtonAction:(UIButton *)button {
    button.selected = !button.isSelected;
    [_liveSession setEnableSkin:button.isSelected];
}

- (void)flashButtonClick:(UIButton *)button {
    button.selected = !button.isSelected;
    _liveSession.torchMode = button.isSelected ? AVCaptureTorchModeOn : AVCaptureTorchModeOff;
}

// 底部工具栏按钮
- (void)commentButtonAction:(UIButton *)button {
    [_textField becomeFirstResponder];
}

// 礼物
- (void)giftButtonAction:(UIButton *)giftButton {
    [UIView animateWithDuration:0.5 animations:^{
        _giftView.frame = CGRectMake(0, SCREEN_HEIGHT * 0.6, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4);
    }];
    [self.view bringSubviewToFront:_giftView];
    _giftView.userInteractionEnabled = YES;
}

- (void)keyboardButtonAction:(UIButton *)button {
    if (_textField.text.length > 0) {
        [self addMessage];
        [_textField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField resignFirstResponder];
}

// textField跟随键盘
- (void) keyboardWillShowAction:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;  // 得到键盘弹出后的键盘视图所在y坐标
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // 添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        _keyboardView.center = CGPointMake(_keyboardView.center.x, keyBoardEndY - _keyboardView.bounds.size.height/2.0);   // keyBoardEndY的坐标包括了状态栏的高度，要减去
        _commentTableView.center = CGPointMake(_commentTableView.center.x, keyBoardEndY - 50 -_commentTableView.height / 2.0);
    }];
}

- (void) keyboardWillHideAction:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;  // 得到键盘弹出后的键盘视图所在y坐标
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // 添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        _keyboardView.center = CGPointMake(_keyboardView.center.x, keyBoardEndY - _keyboardView.bounds.size.height/2.0);   // keyBoardEndY的坐标包括了状态栏的高度，要减去
        _commentTableView.center = CGPointMake(_commentTableView.center.x, keyBoardEndY - 50 -_commentTableView.height / 2.0);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        _keyboardView.center = CGPointMake(_keyboardView.center.x, SCREEN_HEIGHT + _keyboardView.height / 2);
    }];
}

// AVIMClient协议方法
- (void)conversation:(AVIMConversation *)conversation didReceiveCommonMessage:(nonnull AVIMMessage *)message {
    NSString *str;
    NSData *jsonData = [message.content dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!error) {
        NSString *msg = [dic objectForKey:@"_lctext"];
        str = [NSString stringWithFormat:@"%@: %@", message.clientId, msg];
    }
    [_messageArray addObject:str];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_messageArray.count - 1 inSection:0];
    [_commentTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [_commentTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}

- (void)imClientPaused:(AVIMClient *)imClient {
    UIAlertController *alerat = [UIAlertController alertControllerWithTitle:@"" message:@"网络太差" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alerat addAction:action];
    [self presentViewController:alerat animated:YES completion:nil];
}

- (void)animationWithItemCount:(NSInteger)itemCount {
//    NSLog(@"动画编号:%ld", itemCount);
    
    NSLog(@"%ld", i);
    
    i++;
    
    if (0 == itemCount) {
        // IM 消息
        GSPChatMessage *msg = [[GSPChatMessage alloc] init];
        msg.text = @"1个【玫瑰花】";
        
        msg.senderChatID = @"亮锅";
        msg.senderName = msg.senderChatID;
        NSLog(@"id %@ -------送了1个【玫瑰花】--------",msg.senderChatID);
        
        // 礼物模型
        GiftModel *giftModel = [[GiftModel alloc] init];
        giftModel.headImage = [UIImage imageNamed:@"FF885B69C30A56A3D0296F10CFF6D1D8"];
        giftModel.name = msg.senderName;
        giftModel.giftImage = [UIImage imageNamed:@"gift_flower"];
        giftModel.giftName = msg.text;
        giftModel.giftCount = 1;
        
        AnimOperationManager *manager = [AnimOperationManager sharedManager];
        manager.parentView = self.view;
        // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
        [manager animWithUserID:[NSString stringWithFormat:@"%@",msg.senderChatID] model:giftModel finishedBlock:^(BOOL result) {
        }];
    } else if (1 == itemCount) {
        // IM 消息
        GSPChatMessage *msg = [[GSPChatMessage alloc] init];
        msg.text = @"1个【樱花】";
        
        msg.senderChatID = @"班长";
        msg.senderName = msg.senderChatID;
        NSLog(@"id %@ -------送了1个【樱花】--------",msg.senderChatID);
        
        // 礼物模型
        GiftModel *giftModel = [[GiftModel alloc] init];
        giftModel.headImage = [UIImage imageNamed:@"CFE1DC2535199A7B6437D2805419BF23"];
        giftModel.name = msg.senderName;
        giftModel.giftImage = [UIImage imageNamed:@"flower"];
        giftModel.giftName = msg.text;
        giftModel.giftCount = 1;
        
        AnimOperationManager *manager = [AnimOperationManager sharedManager];
        manager.parentView = self.view;
        // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
        [manager animWithUserID:[NSString stringWithFormat:@"%@",msg.senderChatID] model:giftModel finishedBlock:^(BOOL result) {
            
        }];
    } else if (2 == itemCount) {
        // IM 消息
        GSPChatMessage *msg = [[GSPChatMessage alloc] init];
        msg.text = @"1个【钻石】";
        
        msg.senderChatID = @"亮锅";
        msg.senderName = msg.senderChatID;
        NSLog(@"id %@ -------送了1个【钻石】--------",msg.senderChatID);
        
        // 礼物模型
        GiftModel *giftModel = [[GiftModel alloc] init];
        giftModel.headImage = [UIImage imageNamed:@"FF885B69C30A56A3D0296F10CFF6D1D8"];
        giftModel.name = msg.senderName;
        giftModel.giftImage = [UIImage imageNamed:@"living_money_icon21"];
        giftModel.giftName = msg.text;
        giftModel.giftCount = 1;
        
        AnimOperationManager *manager = [AnimOperationManager sharedManager];
        manager.parentView = self.view;
        // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
        [manager animWithUserID:[NSString stringWithFormat:@"%@",msg.senderChatID] model:giftModel finishedBlock:^(BOOL result) {
            
        }];
    } else if (3 == itemCount) {
        
        ElCarTwoAnimationView *carImageView2 = [[ElCarTwoAnimationView alloc] initWithFrame:CGRectMake(-100, 100, 100, 40)];
        [self.view addSubview:carImageView2];
        [self.animationImageViews addObject:carImageView2];
        [self playGiftAnimation];
            

    } else if (4 == itemCount) {
        ElCarThreeAnimationView *carImageView3 = [[ElCarThreeAnimationView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 100, 100, 40)];
        [self.view addSubview:carImageView3];
        [self.animationImageViews addObject:carImageView3];
        [self playGiftAnimation];
    
    } else if (5 == itemCount) {
        ElCarFourAnimationView *carImageView4 = [[ElCarFourAnimationView alloc] initWithFrame:CGRectMake(-100, 200, 120, 40)];
        [self.view addSubview:carImageView4];
        [self.animationImageViews addObject:carImageView4];
        [self playGiftAnimation];
    
    } else if (6 == itemCount) {
        ElDolphinAnimationView *imageView = [[ElDolphinAnimationView alloc] initWithFrame:CGRectMake(100, SCREEN_HEIGHT * 0.6 - 200, 200, 200)];
        [self.view addSubview:imageView];
        [self.animationImageViews addObject:imageView];
        [self playGiftAnimation];
        
    } else if (7 == itemCount) {
        ElFireworksAnimationView *imageView = [[ElFireworksAnimationView alloc] initWithFrame:CGRectMake(100, SCREEN_HEIGHT * 0.6 - 200, 200, 200)];
        [self.view addSubview:imageView];
        [self.animationImageViews addObject:imageView];
        [self playGiftAnimation];
        
        
    } else if (8 == itemCount) {
        
        ElHeartAnimationView *heartImageView = [[ElHeartAnimationView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
        [self.view addSubview:heartImageView];
        [self.animationImageViews addObject:heartImageView];
        [self playGiftAnimation];
        
    }  else if (9 == itemCount) {
        
        ElCarAnimationView *carImageView2 = [[ElCarAnimationView alloc] initWithFrame:CGRectMake(-100, 100, 100, 40)];
        [self.view addSubview:carImageView2];
        [self.animationImageViews addObject:carImageView2];
        [self playGiftAnimation];
        
    } else if (10 == itemCount) {
        ElHouseAniamtionView *imageView = [[ElHouseAniamtionView alloc] initWithFrame:CGRectMake(100, 250, self.view.frame.size.width - 200, 200)];
        [self.view addSubview:imageView];
        [self.animationImageViews addObject:imageView];
        [self playGiftAnimation];
    }
}


- (void)playGiftAnimation {
    
    if (self.animationImageViews.count > 0) {
        ElBaseGiftAnimationView *giftImageView = [self.animationImageViews firstObject];
        if (!giftImageView.isGiftAnimating) {
            [giftImageView animationComplete:^(UIImageView *currentView) {
//                @synchronized(self) {
                
                    [self.animationImageViews removeObjectAtIndex:0];
                    [currentView removeFromSuperview];
                    [self playGiftAnimation];
//                }
                
            }];
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
