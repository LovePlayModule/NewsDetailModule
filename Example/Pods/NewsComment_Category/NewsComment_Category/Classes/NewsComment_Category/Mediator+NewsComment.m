//
//  Mediator+NewsComment.m
//  NewsComment_Category
//
//  Created by Yuns on 2017/6/17.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "Mediator+NewsComment.h"

NSString * const kMediatorNewsCommentParamsNewsIDKey = @"newsIDKey";

@implementation Mediator (NewsComment)

- (UIViewController *)NewsComment_viewControllerWithNewsID:(NSString *)newsID
{
    NSDictionary *params = @{kMediatorNewsCommentParamsNewsIDKey : newsID};
    return [self performTarget:@"NewsComment" action:@"viewController" params:params isCacheTarget:NO];
}

@end
