//
//  AppDelegate.h
//  WeiBo
//
//  Created by Luobu on 19/10/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

@property (readonly, nonatomic) NSOperationQueue *apiQueue;

@end

