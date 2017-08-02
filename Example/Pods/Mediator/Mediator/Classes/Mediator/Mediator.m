//
//  Mediator.m
//  BaseModule
//
//  Created by weiying on 2017/2/24.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "Mediator.h"

@interface Mediator ()
@property (nonatomic, strong) NSMutableDictionary *cachedTargetMap;
@end

@implementation Mediator

+ (instancetype)sharedInstance
{
    static Mediator *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
             params:(NSDictionary *)params
      isCacheTarget:(BOOL)isCacheTarget
{
    NSString *targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
    NSString *actionSelString = [NSString stringWithFormat:@"Action_%@:", actionName];
    //1.target
    Class targetClass = nil;
    NSObject *target = self.cachedTargetMap[targetClassString];
    if (target == nil) {
        targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }
    //2.action
    SEL action = NSSelectorFromString(actionSelString);
    if (action == nil) {
        return nil;
    }
    //3.cache
    if (isCacheTarget) {
        self.cachedTargetMap[targetClassString] = target;
    }
    //4.target-action
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([target respondsToSelector:action]) {
        return [target performSelector:action withObject:params];
    }else{
        SEL actionNotFound = NSSelectorFromString(@"notFound:");
        if ([target respondsToSelector:actionNotFound]) {
            return [target performSelector:action withObject:params];
        }else{
            [self.cachedTargetMap removeObjectForKey:targetClassString];
            return nil;
        }
    }
#pragma clang diagnostic pop
}

- (void)releaseCacheTarget:(NSString *)targetName
{
    NSString *targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
    [self.cachedTargetMap removeObjectForKey:targetClassString];
}

#pragma mark - setter / getter
- (NSMutableDictionary *)cachedTargetMap
{
    if (!_cachedTargetMap) {
        _cachedTargetMap = [NSMutableDictionary dictionary];
    }
    return _cachedTargetMap;
}
@end
