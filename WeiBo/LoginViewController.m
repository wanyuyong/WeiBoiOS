//
//  LoginViewController.m
//  WeiBo
//
//  Created by Luobu on 21/10/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import "LoginViewController.h"
#import "TimeLineViewController.h"

@interface LoginViewController ()

@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    loginButton.backgroundColor = BUTTON_BG;
    [loginButton setTitleColor:BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    loginButton.frame = CGRectMake((SCREEN_WIDTH - BUTTON_WIDTH) / 2, 50, BUTTON_WIDTH, BUTTON_HEIGHT);
    [self.view addSubview:loginButton];
    
    UIButton *toTimeLineButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [toTimeLineButton setTitle:@"TimeLine" forState:UIControlStateNormal];
    toTimeLineButton.backgroundColor = BUTTON_BG;
    [toTimeLineButton setTitleColor:BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    [toTimeLineButton addTarget:self action:@selector(timeLineButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    toTimeLineButton.frame = CGRectMake((SCREEN_WIDTH - BUTTON_WIDTH) / 2, 100, BUTTON_WIDTH, BUTTON_HEIGHT);
    [self.view addSubview:toTimeLineButton];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (void)loginButtonPressed {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
}

- (void)timeLineButtonPressed {
    TimeLineViewController *vc = [[TimeLineViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
