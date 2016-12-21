//
//  AppDelegate.m
//  WeiBo
//
//  Created by Luobu on 19/10/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TestViewController.h"
#import "TimeLineViewController.h"
#import "MusicPlayViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    [self initApiQueue];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    LoginViewController *loginViewController = [[LoginViewController alloc] init];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
//    
//    self.window.rootViewController = navigationController;
    
    
//    MusicPlayViewController *vc = [[MusicPlayViewController alloc] init];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
//    self.window.rootViewController = navigationController;
    
    TimeLineViewController *vc = [[TimeLineViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = navigationController;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    kAccessToken = @"2.00Daq2KBEIB6HEd19413db030gy1rI";
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self ];
}


#pragma mark - WeiboSDKDelegate

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
        
        NSLog(@"Token : %@", self.wbtoken);
        NSLog(@"UserID : %@", self.wbCurrentUserID);
        NSLog(@"RefreshToken : %@", self.wbRefreshToken);
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
}

#pragma mark - Init
- (void)initApiQueue {
    _apiQueue = [[NSOperationQueue alloc] init];
    [_apiQueue setMaxConcurrentOperationCount:3];
}

@end
