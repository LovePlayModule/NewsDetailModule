//
//  NewsDetailSectionCommentFooter.h
//  NewsDetailModule
//
//  Created by Yuns on 2017/6/22.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^commentFooterTouchBlock)();

@interface NewsDetailSectionCommentFooter : UITableViewHeaderFooterView

#pragma mark - params
@property (nonatomic, copy) NSString *title;

#pragma mark - interface
+ (instancetype)sectionFooterWithTableView:(UITableView *)tableView;

- (void)commentFooterViewTouchBlock:(commentFooterTouchBlock)touchBlock;

@end
