//
//  Twitter.m
//  WeiBo
//
//  Created by Luobu on 27/10/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import "Twitter.h"

@implementation Twitter

+(Twitter *)objFormDictionary:(NSDictionary *)dic {
    Twitter *twitter = [[Twitter alloc] init];
    twitter.id = [[dic objectForKey:@"id"] integerValue];
    twitter.created_at = [dic objectForKey:@"created_at"];
    twitter.text = [dic objectForKey:@"text"];
    twitter.reposts_count = [[dic objectForKey:@"reposts_count"] integerValue];
    twitter.comments_count = [[dic objectForKey:@"comments_count"] integerValue];
    twitter.user = [User objFormDictionary:[dic objectForKey:@"user"]];
    twitter.thumbnail_pic = [dic objectForKey:@"thumbnail_pic"];
    twitter.bmiddle_pic = [dic objectForKey:@"bmiddle_pic"];
    twitter.original_pic = [dic objectForKey:@"original_pic"];
    twitter.pic_urls = [NSMutableArray arrayWithCapacity:9];
    NSMutableArray *pics = [dic mutableArrayValueForKey:@"pic_urls"];
    if (pics && pics.count != 0) {
        for (id pic in pics) {
            NSString *picPath = [pic objectForKey:@"thumbnail_pic"];
            if (picPath) {
                [twitter.pic_urls addObject:picPath];
            }
        }
    }
    id retweeted_status = [dic objectForKey:@"retweeted_status"];
    if (retweeted_status) {
        twitter.original_twitter = [Twitter objFormDictionary:retweeted_status];
    }

    return twitter;
}

@end
