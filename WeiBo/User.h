//
//  User.h
//  WeiBo
//
//  Created by Luobu on 27/10/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic) NSUInteger id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *avatar_large;
@property (strong, nonatomic) NSString *des;
@property (strong, nonatomic) NSString *profile_image_url;
@property (strong, nonatomic) NSString *gender;
@property (nonatomic) NSUInteger followers_count;
@property (nonatomic) NSUInteger friends_count;
@property (nonatomic) NSUInteger statuses_count;
@property (nonatomic) NSUInteger favourites_count;
@property (nonatomic) BOOL following;
@property (nonatomic) BOOL follow_me;


+(User *)objFormDictionary:(NSDictionary *)dic;

@end
