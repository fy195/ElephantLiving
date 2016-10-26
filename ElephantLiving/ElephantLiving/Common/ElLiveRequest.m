//
//  ElLiveRequest.m
//  ElephantLiving
//
//  Created by dllo on 16/10/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElLiveRequest.h"
#import <QPLive/QPLive.h>

@interface ElLiveRequest ()

@property (nonatomic, strong) QPLiveRequest *request;

@end

@implementation ElLiveRequest

- (instancetype)initResuest {
    self = [super init];
    if (self) {
        self.request = [[QPLiveRequest alloc] init];
    }
    return self;
}

- (void)requestCreateELLiveWithDomain:(NSString *)domain successEL:(void (^)(NSString *, NSString *))successEL failureEL:(void (^)(NSError *))failureEL {
    [_request requestCreateLiveWithDomain:domain success:^(NSString *pushUrl, NSString *pullUrl) {
        successEL(pushUrl, pullUrl);
    } failure:^(NSError *error) {
        failureEL(error);
    }];
}

@end
