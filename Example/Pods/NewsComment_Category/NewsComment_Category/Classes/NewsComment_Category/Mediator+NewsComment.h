//
//  Mediator+NewsComment.h
//  NewsComment_Category
//
//  Created by Yuns on 2017/6/17.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <Mediator/Mediator.h>

@interface Mediator (NewsComment)

- (UIViewController *)NewsComment_viewControllerWithNewsID:(NSString *)newsID;

@end
