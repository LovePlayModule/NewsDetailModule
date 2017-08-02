//
//  NewsDetailWebCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/2/4.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsDetailWebCellNode.h"

#import <Tools/Macros.h>
#import <YYKit/YYKit.h>

@interface NewsDetailWebCellNode ()<UIWebViewDelegate>
//UI
@property (nonatomic, strong) UIWebView *webView;
//Data
@property (nonatomic, strong) NSString *htmlBody;
@property (nonatomic, assign) CGFloat webViewHeight;
@property (nonatomic, copy) webViewFinishLoadBlock finishLoadBlock;
@end

@implementation NewsDetailWebCellNode

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"NewsDetailWebCellNode";
    NewsDetailWebCellNode *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NewsDetailWebCellNode alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubviews];
    }
    return self;
}

#pragma mark - private
- (void)addSubviews
{
    [self.contentView addSubview:self.webView];
}

#pragma mark - public
- (void)webViewDidFinishLoadBlock:(webViewFinishLoadBlock)finishLoadBlock
{
    _finishLoadBlock = finishLoadBlock;
}

- (void)setupHtmlBoby:(NSString *)htmlBody
{
    _htmlBody = htmlBody;
    if (htmlBody.length > 0) {
        NSBundle *bundle = [NSBundle bundleWithURL: [[NSBundle bundleForClass:[self class]] URLForResource:@"NewsDetailModule" withExtension:@"bundle"]];
        NSURL *cssURL = [NSURL fileURLWithPath:[bundle pathForResource:@"NewsDetail" ofType:@"css"]];
        [_webView loadHTMLString:[self handleWithHtmlBody:htmlBody] baseURL:cssURL];
    }
}

- (NSString *)handleWithHtmlBody:(NSString *)htmlBody
{
    NSString *html = [htmlBody stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSString *cssName = @"NewsDetail.css";
    NSMutableString *htmlString =[[NSMutableString alloc]initWithString:@"<html>"];
    [htmlString appendString:@"<head><meta charset=\"UTF-8\">"];
    [htmlString appendString:@"<link rel =\"stylesheet\" href = \""];
    [htmlString appendString:cssName];
    [htmlString appendString:@"\" type=\"text/css\" />"];
    [htmlString appendString:@"</head>"];
    [htmlString appendString:@"<body>"];
    [htmlString appendString:html];
    [htmlString appendString:@"</body>"];
    [htmlString appendString:@"</html>"];
    return htmlString;
}

#pragma mark - webView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue] + 10;
    _webViewHeight = webViewHeight;
    
    if (_finishLoadBlock) {
        _finishLoadBlock(webViewHeight);
    }
}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_webViewHeight > 0) {
        _webView.height = _webViewHeight;
    }
}

#pragma mark - other
- (void)dealloc
{
    _webView.delegate = nil;
    _webView = nil;
}


#pragma mark - setter / getter
- (UIWebView *)webView
{
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        webView.backgroundColor = [UIColor whiteColor];
        webView.scalesPageToFit = NO;
        webView.delegate = self;
        webView.scrollView.bounces = NO;
        [webView setAutoresizingMask:UIViewAutoresizingNone];
        [webView.scrollView setScrollEnabled:NO];
        [webView.scrollView setScrollsToTop:NO];
        _webView = webView;
    }
    return _webView;
}
@end
