//
//  Twitter.h
//  WeiBo
//
//  Created by Luobu on 27/10/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Twitter : NSObject

@property (nonatomic) NSUInteger id;
@property (strong, nonatomic) NSString *created_at;
@property (strong, nonatomic) NSString *text;
@property (nonatomic) NSUInteger reposts_count;
@property (nonatomic) NSUInteger comments_count;
@property (strong, nonatomic) NSString *thumbnail_pic;
@property (strong, nonatomic) NSString *bmiddle_pic;
@property (strong, nonatomic) NSString *original_pic;
@property (strong, nonatomic) NSMutableArray *pic_urls;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Twitter *original_twitter;

+(Twitter *)objFormDictionary:(NSDictionary *)dic;

@end
