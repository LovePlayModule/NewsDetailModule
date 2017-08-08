//
//  LpViewController.m
//  NewsDetailModule
//
//  Created by YunsChou on 08/02/2017.
//  Copyright (c) 2017 YunsChou. All rights reserved.
//

#import "LpViewController.h"
#import <Network/HttpRequest.h>
#import <NewsDetailModule/Target_NewsDetail.h>

@interface LpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *newsIDTextField;

@end

@implementation LpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[HttpRequest sharedInstance] configBaseURL:@"https://i.play.163.com"];
    
}

- (IBAction)pushToNext:(id)sender {
    
    NSDictionary *params = @{@"newsIDKey" : self.newsIDTextField.text};
    Target_NewsDetail *target = [[Target_NewsDetail alloc] init];
    UIViewController *viewController = [target Action_viewController:params];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
