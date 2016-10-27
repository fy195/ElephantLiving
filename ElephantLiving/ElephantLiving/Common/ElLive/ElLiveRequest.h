//
//  ElLiveRequest.h
//  ElephantLiving
//
//  Created by dllo on 16/10/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ElConfiguration.h"

@interface ElLiveRequest : NSObject

- (instancetype)initResuest;

- (void)requestCreateELLiveWithDomain:(NSString *)domain successEL:(void(^)(NSString *pushUrl, NSString *pullUrl))successEL failureEL:(void(^)(NSError *error))failureEL;

@end
