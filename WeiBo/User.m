//
//  User.m
//  WeiBo
//
//  Created by Luobu on 27/10/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import "User.h"

@implementation User

+(User *)objFormDictionary:(NSDictionary *)dic {
    User *user = [[User alloc] init];
    user.id = [[dic objectForKey:@"id"] integerValue];
    user.name = [dic objectForKey:@"name"];
    user.avatar_large = [dic objectForKey:@"avatar_large"];
    user.location = [dic objectForKey:@"location"];
    user.des = [dic objectForKey:@"description"];
    user.profile_image_url = [dic objectForKey:@"profile_image_url"];
    user.gender = [dic objectForKey:@"gender"];
    user.followers_count = [[dic objectForKey:@"followers_count"] integerValue];
    user.friends_count = [[dic objectForKey:@"friends_count"] integerValue];
    user.statuses_count = [[dic objectForKey:@"statuses_count"] integerValue];
    user.favourites_count = [[dic objectForKey:@"favourites_count"] integerValue];
    user.following = [[dic objectForKey:@"following"] integerValue] == 1;
    user.follow_me = [[dic objectForKey:@"follow_me"] integerValue] == 1;
    
    return user;
}

@end
