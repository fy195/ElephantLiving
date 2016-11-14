//
//  AVObject+ElClassMap.m
//  
//
//  Created by dllo on 16/11/3.
//
//

#import "AVObject+ElClassMap.h"

@implementation AVObject (ElClassMap)

+ (instancetype)objectWithClassName:(NSString *)className {
    Class class = NSClassFromString(className);
    if ([class isSubclassOfClass:[self class]]) {
        return [[class alloc] initWithClassName:className];
    }
    return [[self alloc] initWithClassName:className];
}

@end
