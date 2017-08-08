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
    //1.target
    NSString *targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
    Class targetClass = nil;
    NSObject *target = self.cachedTargetMap[targetClassString];
    if (target == nil) {
        targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }
    //2.action
    NSString *actionSelString = [NSString stringWithFormat:@"Action_%@:", actionName];
    SEL action = NSSelectorFromString(actionSelString);
    if (action == nil) {
        UIViewController *viewController = [self exceptoinViewController:@"Action is nil"];
        return viewController;
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
            UIViewController *viewController = [self exceptoinViewController:@"Not this Action"];
            return viewController;
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

- (UIViewController *)exceptoinViewController:(NSString *)exceptoin
{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewController.view.bounds.size.width, 30)];
    label.center = viewController.view.center;
    label.text = exceptoin;
    label.textAlignment = NSTextAlignmentCenter;
    [viewController.view addSubview:label];
    return viewController;
}
@end
