//
//  AnimOperation.m
//  动画
//
//  Created by Omaiga on 2016/11/1.
//  Copyright © 2016年 Omaiga. All rights reserved.
//

#import "AnimOperation.h"
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface AnimOperation ()

@property (nonatomic, getter= isFinished)BOOL Finished;

@property (nonatomic, getter= isExecuting)BOOL Executing;

@property (nonatomic,copy) void(^finishedBlock)(BOOL result,NSInteger finishCount);

@end

@implementation AnimOperation

@synthesize finished = _finished;
@synthesize executing = _executing;

+ (instancetype)animOperationWithUserID:(NSString *)userID model:(GiftModel *)model finishedBlock:(void (^)(BOOL, NSInteger))finishedBlock {

    AnimOperation *op = [[AnimOperation alloc] init];
    op.presentView = [[PresentView alloc] init];
    op.model = model;
    op.finishedBlock = finishedBlock;
    return op;

}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _Executing = YES;
        _Finished = YES;
        
    }
    return self;
}

- (void)start {

    if ([self isCancelled]) {
        self.Finished = YES;
        return;
    }
    self.Executing = YES;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _presentView.model = _model;
        
        _presentView.originFrame = _presentView.frame;
        
        [self.listView addSubview:_presentView];
        
        [self.presentView animateWithCompleteBlock:^(BOOL finished, NSInteger finishCount) {
            self.Finished = finished;
            self.finishedBlock(finished, finishCount);
        }];
    }];

}

#pragma mark -  手动触发 KVO
- (void)setExecuting:(BOOL)executing
{
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished
{
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

@end
