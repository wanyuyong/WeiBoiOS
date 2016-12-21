//
//  WBHttpRequest+TimeLine.h
//  WeiBo
//
//  Created by Luobu on 26/10/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import "WBHttpRequest.h"

@interface WBHttpRequest (TimeLine)

+ (WBHttpRequest *)requestForFriendTimeLine:(NSString*)accessToken
                                    sinceId:(NSUInteger)sinceId
                                      maxId:(NSUInteger)maxId
                                      count:(NSUInteger)count
                                       page:(NSUInteger)page
                                    baseApp:(NSUInteger)baseApp
                                    feature:(NSUInteger)feature
                                  trim_user:(NSUInteger)trimUser
                      withCompletionHandler:(WBRequestHandler)handler;

@end
