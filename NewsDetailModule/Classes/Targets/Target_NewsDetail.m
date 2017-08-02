//
//  Target_NewsDetail.m
//  NewsDetailModule
//
//  Created by Yuns on 2017/6/22.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "Target_NewsDetail.h"
#import "NewsDetailViewController.h"

@implementation Target_NewsDetail

- (UIViewController *)Action_viewController:(NSDictionary *)params
{
    NewsDetailViewController *viewController = [[NewsDetailViewController alloc] init];
    viewController.newsID = params[@"newsIDKey"];
    return viewController;
}

@end
