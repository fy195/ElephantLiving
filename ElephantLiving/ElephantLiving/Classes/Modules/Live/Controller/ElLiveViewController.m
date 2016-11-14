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
#import "_User.h"
#import "ElLiveRoom.h"
#import "AVObject+ElClassMap.h"
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
#import "ElCommentTableViewCell.h"
#import "ElUserBriefView.h"
#import "ElReportViewController.h"
#import "NSString+ElAutoSize.h"


@interface ElLiveViewController ()
<
QPLiveSessionDelegate,
AVIMClientDelegate,
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource,
ElGiftViewDelegate,
ElLivingTopViewDelegate,
ElUserBriefViewDelegate
>


@property (nonatomic, strong) ElLiveRoom *liveRoom;
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
@property (nonatomic, strong) ElUserBriefView *userBriefView;
@property (nonatomic, strong) _User *liveUser;

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
    
    self.userBriefView = [ElUserBriefView elUserBriefView];
    _userBriefView.frame = CGRectMake(SCREEN_WIDTH * 0.15, SCREEN_HEIGHT, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT * 0.45);
    _userBriefView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.85];
    _userBriefView.delegate = self;
    [self.view addSubview:_userBriefView];
    
    [self createToolView];
    
    self.timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _timeImageView.center = self.view.center;
    _timeImageView.backgroundColor = [UIColor   clearColor];
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    [self.view addGestureRecognizer:gesture];
    
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
    _topToolView.delegate = self;
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
    [_bottomToolView.shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.giftView = [[ElGiftView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4)];
    [self.view addSubview:_giftView];
    _giftView.delegate = self;

    [self.view addSubview:_bottomToolView];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.frame = CGRectMake(SCREEN_WIDTH - 22 - 30, SCREEN_HEIGHT - 20 - 30, 30, 30);
    _closeButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
    _closeButton.layer.cornerRadius = 15.0;
    _closeButton.clipsToBounds = YES;
    [_closeButton setBackgroundImage:[UIImage imageNamed:@"关闭-1"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeButton];
    [self.view bringSubviewToFront:_closeButton];
    [self createCommentTableView];
    
    [self hiddenToolView:YES];
}

- (void)shareButtonAction:(UIButton *)button {
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"smalltiger"] applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypeMail];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

// 创建tableView
- (void)createCommentTableView {
    self.commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 270, SCREEN_WIDTH - 70, 200) style:UITableViewStylePlain];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.backgroundColor = [UIColor clearColor];
    _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _commentTableView.bounces = NO;
    [self.view addSubview:_commentTableView];
    [self.view bringSubviewToFront:_commentTableView];
    [_commentTableView registerClass:[ElCommentTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 270, SCREEN_WIDTH - 70, 30)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [[UIColor purpleColor] colorWithAlphaComponent:0.8];
    label.text = @"系统消息:大象直播提倡绿色直播,封面和直播内容含低俗、诱惑、暴露、暴力、赌博等内容都将被屏蔽热门或封停帐号,网警24小时在线巡查!官方严禁私下交易货币,如遇纠纷,概不负责!";
    label.numberOfLines = 0;
    [label sizeToFit];
    _commentTableView.tableHeaderView = label;
    
    
    self.client = [AVIMClient defaultClient];
    _client.delegate = self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_messageArray[indexPath.row] cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ElCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.comment = _messageArray[indexPath.row];
    return cell;
}

- (void)addMessage {
    AVIMMessageOption *option = [[AVIMMessageOption alloc] init];
    option.receipt = YES;
    AVIMTextMessage *textMessage = [AVIMTextMessage messageWithText:_textField.text attributes:nil];
    [_currentConversation sendMessage:textMessage option:option callback:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            [_messageArray addObject:[NSString stringWithFormat:@"%@: %@", textMessage.clientId, textMessage.text]];
            [_commentTableView reloadData];
            [self tableViewScrollToBottom];
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
        [self timeEnd];
        [_liveRoom deleteInBackground];
        [_liveSession disconnectServer];
        [_liveSession stopPreview];
        _endView.hidden = NO;
        _endView.time = _timeString;
        _endView.view_count = _topToolView.watchCount;
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
- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture{
    CGPoint point = [gesture locationInView:self.view];
    CGPoint percentPoint = CGPointZero;
    percentPoint.x = point.x / CGRectGetWidth(self.view.bounds);
    percentPoint.y = point.y / CGRectGetHeight(self.view.bounds);
    [_liveSession focusAtAdjustedPoint:percentPoint autoFocus:YES];
}

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
    [_liveRoom fetchInBackgroundWithBlock:^(AVObject * _Nullable object, NSError * _Nullable error) {
        _topToolView.watchCount = _liveRoom.view_count;
    }];
}

//  直播时长
- (void)timeEnd {
    _User *user = [_User currentUser];
    user.livingTime = user.livingTime + _timeNumber;
    user.level = [NSNumber numberWithInteger:user.livingTime / 3600];
    user.charm = [user.level integerValue] * [user.follower_count integerValue];
    [user saveInBackground];
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

    _User *currentUser = [_User currentUser];
    self.liveRoom = [[ElLiveRoom alloc] initWithClassName:NSStringFromClass([ElLiveRoom class])];
    /**
     *  拉流地址
     */
    _liveRoom.pullUrl = _pullUrl;
    /**
     *  主播名称
     */
    _liveRoom.host_name = currentUser.username;
    _liveRoom.userObjectId = currentUser.objectId;
    _liveRoom.level = currentUser.level;
    _liveRoom.headerImage = currentUser.headImage;
    _liveRoom.coverImage = currentUser.headImage;
    /**
     *  直播间标题
     */
    _liveRoom.liveRoom_title = _startView.nameTextField.text;
    
    [_liveRoom saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"保存成功");
    }];
    _topToolView.headerImage = _liveRoom.headerImage;
    _userBriefView.name = _liveRoom.host_name;
    _userBriefView.level = _liveRoom.level;
    _userBriefView.image = _liveRoom.headerImage;
}

// 创建聊天室
- (void)createChatRoom {
    _User *user = [_User currentUser];
    self.client = [[AVIMClient alloc] initWithClientId:user.username];
    _client.delegate = self;
    [_client openWithCallback:^(BOOL succeeded, NSError * _Nullable error) {
        NSString *topic = _liveRoom.host_name;
        NSDictionary *dic = @{@"topic":topic};
        [_client createConversationWithName:topic clientIds:@[] attributes:dic options:AVIMConversationOptionTransient callback:^(AVIMConversation * _Nullable conversation, NSError * _Nullable error) {
            if (!error) {
                self.currentConversation = conversation;
                NSLog(@"创建聊天室成功");
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
    [UIView animateWithDuration:0.5 animations:^{
        _giftView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4);
    }];
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
    [_commentTableView reloadData];
    [self tableViewScrollToBottom];
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
    _User *user = [_User currentUser];
    if (0 == itemCount) {
        // IM 消息
        GSPChatMessage *msg = [[GSPChatMessage alloc] init];
        msg.text = @"1个【玫瑰花】";
        msg.senderChatID = user.username;
        msg.senderName = msg.senderChatID;
    
        // 礼物模型
        GiftModel *firstGiftModel = [[GiftModel alloc] init];
        firstGiftModel.headImage = user.headImage;
        firstGiftModel.name = msg.senderName;
        firstGiftModel.giftImage = [UIImage imageNamed:@"gift_flower"];
        firstGiftModel.giftName = msg.text;
        firstGiftModel.giftCount = 1;
        [self.animationImageViews addObject:firstGiftModel];
        
        AnimOperationManager *manager = [AnimOperationManager sharedManager];
        manager.parentView = self.view;
        // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
        [manager animWithUserID:[NSString stringWithFormat:@"%@",msg.senderChatID] model:firstGiftModel finishedBlock:^(BOOL result) {
        }];
    } else if (1 == itemCount) {
        // IM 消息
        GSPChatMessage *msg = [[GSPChatMessage alloc] init];
        msg.text = @"1个【樱花】";
        msg.senderChatID = user.username;
        msg.senderName = msg.senderChatID;
        
        // 礼物模型
        GiftModel *secondGiftModel = [[GiftModel alloc] init];
        secondGiftModel.headImage = user.headImage;
        secondGiftModel.name = msg.senderName;
        secondGiftModel.giftImage = [UIImage imageNamed:@"flower"];
        secondGiftModel.giftName = msg.text;
        secondGiftModel.giftCount = 1;
        
        AnimOperationManager *manager = [AnimOperationManager sharedManager];
        manager.parentView = self.view;
        // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
        [manager animWithUserID:[NSString stringWithFormat:@"%@",msg.senderChatID] model:secondGiftModel finishedBlock:^(BOOL result) {
            
        }];
    } else if (2 == itemCount) {
        // IM 消息
        GSPChatMessage *msg = [[GSPChatMessage alloc] init];
        msg.text = @"1个【钻石】";
        msg.senderChatID = user.username;
        msg.senderName = msg.senderChatID;
        
        // 礼物模型
        GiftModel *thirdGiftModel = [[GiftModel alloc] init];
        thirdGiftModel.headImage = user.headImage;
        thirdGiftModel.name = msg.senderName;
        thirdGiftModel.giftImage = [UIImage imageNamed:@"living_money_icon21"];
        thirdGiftModel.giftName = msg.text;
        thirdGiftModel.giftCount = 1;
        
        AnimOperationManager *manager = [AnimOperationManager sharedManager];
        manager.parentView = self.view;
        // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
        [manager animWithUserID:[NSString stringWithFormat:@"%@",msg.senderChatID] model:thirdGiftModel finishedBlock:^(BOOL result) {
 
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
        ElFireworksAnimationView *imageView = [[ElFireworksAnimationView alloc] initWithFrame:SCREEN_RECT];
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
                [self.animationImageViews removeObjectAtIndex:0];
                [currentView removeFromSuperview];
                [self playGiftAnimation];
            }];
        }
    }

}

- (void)follow:(BOOL)isFollow {
    _User *currentUser = [_User currentUser];
    if (!isFollow) {
        [currentUser follow:_liveUser.objectId andCallback:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                currentUser.follow_count = [NSNumber numberWithInteger:[currentUser.follow_count integerValue]+ 1];
                currentUser.fetchWhenSave = true;
                [currentUser saveInBackground];
                _liveUser.follower_count = [NSNumber numberWithInteger:[_liveUser.follower_count integerValue] + 1];
                _liveUser.fetchWhenSave = true;
                [_liveUser saveInBackground];
                [_userBriefView.followButton setTitle:@"已关注" forState:UIControlStateNormal];
                _userBriefView.isFollow = YES;
            }else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }else {
        [currentUser unfollow:_liveUser.objectId andCallback:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                currentUser.follow_count = [NSNumber numberWithInteger:[currentUser.follow_count integerValue]- 1];
                currentUser.fetchWhenSave = true;
                [currentUser saveInBackground];
                _liveUser.follower_count = [NSNumber numberWithInteger:[currentUser.follower_count integerValue] - 1];
                _liveUser.fetchWhenSave = true;
                [_liveUser saveInBackground];
                [_userBriefView.followButton setTitle:@"+ 关注" forState:UIControlStateNormal];
                _userBriefView.isFollow = NO;
            }else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
}

- (void)report {
    ElReportViewController *reportViewController = [[ElReportViewController alloc] init];
    [self presentViewController:reportViewController animated:YES completion:nil];
}

- (void)presentBriefView {
    [UIView animateWithDuration:0.5 delay:0.0f usingSpringWithDamping:0.7 initialSpringVelocity:-3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _userBriefView.frame = CGRectMake(SCREEN_WIDTH * 0.15, SCREEN_HEIGHT * 0.25, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT * 0.45);
    } completion:nil];
    _User *currentUser = [_User currentUser];
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:_liveRoom.userObjectId block:^(AVObject * _Nullable object, NSError * _Nullable error) {
        self.liveUser = (_User *)object;
    }];
    [_liveUser getFollowers:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        for (_User *user in objects) {
            if ([currentUser.objectId isEqualToString: user.objectId]) {
                [_userBriefView.followButton setTitle:@"已关注" forState:UIControlStateNormal];
                _userBriefView.isFollow = YES;
            }else {
                _userBriefView.isFollow = NO;
            }
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [UIView animateWithDuration:0.5 animations:^{
        _giftView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4);
    }];

}
- (void)tableViewScrollToBottom {
    if (_messageArray.count == 0) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_messageArray.count - 1 inSection:0];
    [_commentTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
