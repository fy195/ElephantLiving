//
//  ElBaseModel.m
//  ElephantLiving
//
//  Created by dllo on 16/10/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElBaseModel.h"
#import "MJExtension.h"
#import "AVOSCloud/AVOSCloud.h"

@implementation ElBaseModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mapAVObject = [[AVObject alloc] initWithClassName:@"LiveRoom"];
    }
    return self;
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (ElBaseModel *)modelWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}


- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    
    if (![key isEqualToString:@"mapAVObject"]) {
        
        [_mapAVObject setValue:value forKey:key];
    }
}

- (id)valueForKey:(NSString *)key {
    return [_mapAVObject valueForKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}


+ (NSArray *)modelArrayWithArray:(NSArray *)avObjectArray {
    
    NSMutableArray *modelArray = [NSMutableArray array];
    for (AVObject *object in avObjectArray) {
        ElBaseModel *baseModel = [[self class] new];
        baseModel.mapAVObject = object;
        [modelArray addObject:baseModel];
    }
    return [NSArray arrayWithArray:modelArray];
}
@end
