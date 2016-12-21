//
//  WBHttpRequest+TimeLine.m
//  WeiBo
//
//  Created by Luobu on 26/10/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import "WBHttpRequest+TimeLine.h"
#import "ApiConstant.h"

@implementation WBHttpRequest (TimeLine)

+ (WBHttpRequest *)requestForFriendTimeLine:(NSString *)accessToken sinceId:(NSUInteger)sinceId maxId:(NSUInteger)maxId count:(NSUInteger)count page:(NSUInteger)page baseApp:(NSUInteger)baseApp feature:(NSUInteger)feature trim_user:(NSUInteger)trimUser withCompletionHandler:(WBRequestHandler)handler {
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjects:@[accessToken, [NSString stringWithFormat: @"%lu", sinceId],
                                                                   [NSString stringWithFormat: @"%lu", maxId],
                                                                   [NSString stringWithFormat: @"%lu", count],
                                                                   [NSString stringWithFormat: @"%lu", page],
                                                                   [NSString stringWithFormat: @"%lu", baseApp],
                                                                   [NSString stringWithFormat: @"%lu", feature],
                                                                   [NSString stringWithFormat: @"%lu", trimUser]]
                                                         forKeys:@[@"access_token", @"since_id", @"max_id", @"count", @"page", @"base_app", @"feature", @"trim_user"]];
    
    return [WBHttpRequest requestWithAccessToken:accessToken
                                      url:APIFriendsTimeline
                               httpMethod:GET
                                   params:params
                                    queue:kAppDelegate.apiQueue
                    withCompletionHandler:handler];
}

@end
