//
//  NewsDetailRelativeCellNode.h
//  NewsDetailModule
//
//  Created by Yuns on 2017/6/22.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsRelativeInfo;
@interface NewsDetailRelativeCellNode : UITableViewCell

#pragma mark - interface
+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setupRelativeInfo:(NewsRelativeInfo *)relativeInfo;

@end
