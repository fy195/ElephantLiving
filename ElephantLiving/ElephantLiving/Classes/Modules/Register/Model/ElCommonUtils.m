//
//  ElCommonUtils.m
//  ElephantLiving
//
//  Created by Omaiga on 2016/10/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElCommonUtils.h"

@implementation ElCommonUtils

+ (void)displayError:(NSError*)error {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发生错误" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    
}

@end
