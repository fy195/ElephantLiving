//
//  ElWatchViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElWatchViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "ElLivingTopView.h"
#import "ElLivingBottomToolView.h"
#import "AVOSCloudIM.h"
#import "AVIMConversation.h"
#import "_User.h"
#import "LiveRoom.h"
#import "ElLiveRoom.h"
#import "AVObject+ElClassMap.h"
#import "ElUserBriefView.h"
#import "UIImageView+WebCache.h"
#import "ElReportViewController.h"
#import "ElGiftView.h"
#import "GSPChatMessage.h"
#import "GiftModel.h"
#import "AnimOperation.h"
#import "AnimOperationManager.h"
#import "ElHeartAnimationView.h"
#import "ElCarAnimationView.h"
#import "ElCarTwoAnimationView.h"
#import "ElCarThreeAnimationView.h"
#import "ElCarFourAnimationView.h"
#import "ElDolphinAnimationView.h"
#import "ElFireworksAnimationView.h"
#import "ElHouseAniamtionView.h"
#import "ElBaseGiftAnimationView.h"
#import "ElCommentTableViewCell.h"
#import "NSString+ElAutoSize.h"

@interface ElWatchViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
AVIMClientDelegate,
ElUserBriefViewDelegate,
ElLivingTopViewDelegate,
ElGiftViewDelegate
>

@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UITableView *commentTableView;
@property (nonatomic, retain) NSMutableArray *messageArray;
@property (nonatomic, strong) AVIMClient *client;
@property (nonatomic, strong) AVIMConversation *currentConversation;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *keyboardView;
@property (nonatomic, strong) UIButton *keyboardButton;
@property (nonatomic, strong) ElUserBriefView *userBriefView;
@property (nonatomic, strong) ElGiftView *giftView;
@property (nonatomic, strong) NSMutableArray *animationImageViews;
@property (nonatomic, strong) _User *liveUser;


@end

@implementation ElWatchViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

- (NSMutableArray *)animationImageViews {
    if (nil == _animationImageViews) {
        _animationImageViews = [NSMutableArray array];
    }
    return _animationImageViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    if (_liveRoom == nil) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:_elLiveRoom.coverImage]];
    }else {
        [imageView sd_setImageWithURL:[NSURL URLWithString:_liveRoom.coverImage]];
    }
    
    [self.view addSubview:imageView];
    [self playFlv];
    [self creatTool];
    
    self.messageArray = [NSMutableArray array];
    [self searchChatRoom];
    
    self.userBriefView = [ElUserBriefView elUserBriefView];
    _userBriefView.frame = CGRectMake(SCREEN_WIDTH * 0.15, SCREEN_HEIGHT, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT * 0.45);
    _userBriefView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.85];
    _userBriefView.delegate = self;
    if (_liveRoom == nil) {
        _userBriefView.name = _elLiveRoom.host_name;
        _userBriefView.level = _elLiveRoom.level;
        _userBriefView.image = _elLiveRoom.headerImage;
    }else {
        _userBriefView.name = _liveRoom.host_name;
        _userBriefView.level = _liveRoom.level;
        _userBriefView.image = _liveRoom.headerImage;
    }
    [self.view addSubview:_userBriefView];
    
    // Do any additional setup after loading the view from its nib.
}

// 搜索聊天室
- (void)searchChatRoom {
    if(_liveRoom == nil) {
        _User *user = [_User currentUser];
        self.client = [[AVIMClient alloc] initWithClientId:user.username];
        _client.delegate = self;
        [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
            AVIMConversationQuery *query = [self.client conversationQuery];
            [query whereKey:AVIMAttr(@"topic") equalTo:_elLiveRoom.host_name];
            // 额外调用一次确保查询的是聊天室而不是普通对话
            [query whereKey:@"tr" equalTo:@(YES)];
            [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
                self.currentConversation = objects.lastObject;
                [objects.lastObject joinWithCallback:^(BOOL succeeded, NSError * _Nullable error) {
                    //NSLog(@"加入对话成功");
                }];
                //NSLog(@"查询成功");
            }];
        }];
    }else {
        _User *user = [_User currentUser];
        self.client = [[AVIMClient alloc] initWithClientId:user.username];
        _client.delegate = self;
        [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
            AVIMConversationQuery *query = [self.client conversationQuery];
            [query whereKey:AVIMAttr(@"topic") equalTo:_liveRoom.host_name];
            // 额外调用一次确保查询的是聊天室而不是普通对话
            [query whereKey:@"tr" equalTo:@(YES)];
            [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
                self.currentConversation = objects.lastObject;
                [objects.lastObject joinWithCallback:^(BOOL succeeded, NSError * _Nullable error) {
                    //NSLog(@"加入对话成功");
                }];
                //NSLog(@"查询成功");
            }];
        }];
    }
}

- (void)creatTool {
    [self createKeyboardView];
    
    ElLivingTopView *topToolView = [ElLivingTopView elLivingTopView];
    topToolView.frame = CGRectMake(0, 20, SCREEN_WIDTH, 57);
    topToolView.backgroundColor = [UIColor clearColor];
    if (_liveRoom == nil) {
        topToolView.headerImage = _elLiveRoom.headerImage;
        topToolView.watchCount = _elLiveRoom.view_count;
    }else {
        topToolView.headerImage = _liveRoom.headerImage;
        topToolView.watchCount = _liveRoom.view_count;
    }
    
    topToolView.delegate = self;
    [_moviePlayer.view addSubview:topToolView];
    
    ElLivingBottomToolView *bottomToolView = [ElLivingBottomToolView elLivingBottomToolView];
    bottomToolView.frame = CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70);
    bottomToolView.backgroundColor = [UIColor clearColor];
    [_moviePlayer.view addSubview:bottomToolView];
    [_moviePlayer.view bringSubviewToFront:bottomToolView];
    [bottomToolView.commentButton addTarget:self action:@selector(commentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomToolView.giftButton addTarget:self action:@selector(giftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomToolView.shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.giftView = [[ElGiftView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4)];
    [self.view addSubview:_giftView];
    _giftView.delegate = self;

    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.frame = CGRectMake(SCREEN_WIDTH - 22 - 30, SCREEN_HEIGHT - 20 - 30, 30, 30);
    _closeButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
    _closeButton.layer.cornerRadius = 15.0;
    _closeButton.clipsToBounds = YES;
    [_closeButton setBackgroundImage:[UIImage imageNamed:@"关闭-1"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_moviePlayer.view addSubview:_closeButton];
    [_moviePlayer.view bringSubviewToFront:_closeButton];
    
    self.commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 270, SCREEN_WIDTH - 70, 200) style:UITableViewStylePlain];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.backgroundColor = [UIColor clearColor];
    _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_commentTableView];
    [self.view bringSubviewToFront:_commentTableView];
    [_commentTableView registerClass:[ElCommentTableViewCell class] forCellReuseIdentifier:@"cell"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 270, SCREEN_WIDTH - 70, 30)];
    label.textColor = [[UIColor purpleColor] colorWithAlphaComponent:0.8];
    label.text = @"系统消息:大象直播提倡绿色直播,封面和直播内容含低俗、诱惑、暴露、暴力、赌博等内容都将被屏蔽热门或封停帐号,网警24小时在线巡查!官方严禁私下交易货币,如遇纠纷,概不负责!";
    label.numberOfLines = 0;
    [label sizeToFit];
    _commentTableView.tableHeaderView = label;
    
    self.client = [AVIMClient defaultClient];
    _client.delegate = self;
}

- (void)shareButtonAction:(UIButton *)button {
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"smalltiger"] applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypeMail];
    [self presentViewController:activityViewController animated:YES completion:nil];
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

- (void)closeButtonAction:(UIButton *)button {
 
    [_moviePlayer shutdown];
    _moviePlayer = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playFlv {
    if (_moviePlayer) {
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    [options setPlayerOptionIntValue:1 forKey:@"audiotoolbox"];
    [options setPlayerOptionIntValue:15 forKey:@"r"];
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    if (_liveRoom == nil) {
        self.moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_elLiveRoom.pullUrl withOptions:options];
    }else {
        self.moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_liveRoom.pullUrl withOptions:options];
    }
    
    _moviePlayer.view.frame = self.view.bounds;
    _moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    _moviePlayer.shouldAutoplay = NO;
    _moviePlayer.shouldShowHudView = NO;
    
    [_moviePlayer prepareToPlay];
    [self initObserver];
    [self.view addSubview:_moviePlayer.view];
}

- (void)initObserver
{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

- (void)didFinish {
    [_moviePlayer.view removeFromSuperview];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"播放结束" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)stateDidChange {
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
        }else{
        }
    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
    }
    
}

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


- (void)commentButtonAction:(UIButton *)button {
    [_textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLiveRoom:(LiveRoom *)liveRoom {
    if (_liveRoom != liveRoom) {
        _liveRoom = liveRoom;
    }
}

- (void)setElLiveRoom:(ElLiveRoom *)elLiveRoom {
    if (_elLiveRoom != elLiveRoom) {
        _elLiveRoom = elLiveRoom;
    }
}

- (void)presentBriefView {
    [UIView animateWithDuration:0.5 delay:0.0f usingSpringWithDamping:0.7 initialSpringVelocity:-3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _userBriefView.frame = CGRectMake(SCREEN_WIDTH * 0.15, SCREEN_HEIGHT * 0.25, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT * 0.45);
    } completion:nil];
    _User *currentUser = [_User currentUser];
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:_elLiveRoom.userObjectId block:^(AVObject * _Nullable object, NSError * _Nullable error) {
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

- (void)report {
    ElReportViewController *reportViewController = [[ElReportViewController alloc] init];
    [self presentViewController:reportViewController animated:YES completion:nil];
}

- (void)follow:(BOOL)isFollow {
    _User *currentUser = [_User currentUser];
    if (!isFollow) {
        [currentUser follow:_liveUser.objectId andCallback:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                currentUser.follow_count = [NSNumber numberWithInteger:[currentUser.follow_count integerValue]+ 1];
                currentUser.fetchWhenSave = true;
                [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {
                        //NSLog(@"存储成功");
                        //NSLog(@"%@", currentUser);
                    }else {
                        //NSLog(@"%@", error);
                    }
                    
                }];
                _liveUser.follower_count = [NSNumber numberWithInteger:[_liveUser.follower_count integerValue] + 1];
                _liveUser.fetchWhenSave = true;
                [_liveUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {
                        //NSLog(@"存储成功");
                        //NSLog(@"%@",_liveUser);
                    }else {
                        //NSLog(@"%@", error);
                    }
                }];
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

// 礼物
- (void)giftButtonAction:(UIButton *)giftButton {
    [UIView animateWithDuration:0.5 animations:^{
        _giftView.frame = CGRectMake(0, SCREEN_HEIGHT * 0.6, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4);
    }];
    [self.view bringSubviewToFront:_giftView];
    _giftView.userInteractionEnabled = YES;
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
        GiftModel *giftModel = [[GiftModel alloc] init];
        giftModel.headImage = user.headImage;
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
        msg.senderChatID = user.username;
        msg.senderName = msg.senderChatID;
        
        // 礼物模型
        GiftModel *giftModel = [[GiftModel alloc] init];
        giftModel.headImage = user.headImage;
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
        msg.senderChatID = user.username;
        msg.senderName = msg.senderChatID;
        
        // 礼物模型
        GiftModel *giftModel = [[GiftModel alloc] init];
        giftModel.headImage = user.headImage;
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

@end
