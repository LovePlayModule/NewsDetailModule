//
//  NewsCommentSectionTitleHeader.m
//  NewsCommentModule
//
//  Created by Yuns on 2017/6/22.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentSectionTitleHeader.h"

#import <Tools/Macros.h>
#import <Masonry/Masonry.h>

@interface NewsCommentSectionTitleHeader ()
//UI
@property (nonatomic, strong) UIView *leftLineView;
@property (nonatomic, strong) UILabel *titleTextLabel;
@end

@implementation NewsCommentSectionTitleHeader

+ (instancetype)sectionHeaderWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"NewsCommentSectionTitleHeader.h";
    NewsCommentSectionTitleHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[NewsCommentSectionTitleHeader alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = RGB(235, 235, 235);
        [self addSubnodes];
        [self mas_subViews];
    }
    return self;
}

#pragma mark - private
- (void)addSubnodes
{
    [self.contentView addSubview:self.leftLineView];
    
    [self.contentView addSubview:self.titleTextLabel];
}

- (void)mas_subViews
{
    [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(3);
        make.top.equalTo(self.contentView).mas_offset(5);
        make.left.equalTo(self.contentView).mas_offset(12);
        make.bottom.equalTo(self.contentView).mas_offset(-5);
    }];
    
    [self.titleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.top.equalTo(self.contentView);
        make.left.equalTo(self.leftLineView.mas_right).mas_offset(8);
    }];
}

#pragma mark - public
- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _titleTextLabel.text = title;
}

#pragma mark - setter / getter
- (UIView *)leftLineView
{
    if (!_leftLineView) {
        UIView *leftLineView = [[UIView alloc] init];
        leftLineView.backgroundColor = RGB(218, 85, 107);
        _leftLineView = leftLineView;
    }
    return _leftLineView;
}

- (UILabel *)titleTextLabel
{
    if (!_titleTextLabel) {
        UILabel *titleTextLabel = [[UILabel alloc] init];
        titleTextLabel.textColor = RGB(155, 155, 155);
        titleTextLabel.font = [UIFont systemFontOfSize:12];
        _titleTextLabel = titleTextLabel;
    }
    return _titleTextLabel;
}

@end
