//
//  TwitterSet.m
//  WeiBo
//
//  Created by Luobu on 27/10/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import "TwitterSet.h"

@implementation TwitterSet

+(TwitterSet *)objFormDictionary:(NSDictionary *)dic {
    TwitterSet *set = [[TwitterSet alloc] init];
    set.previous_cursor = [[dic objectForKey:@"previous_cursor"] integerValue];
    set.next_cursor = [[dic objectForKey:@"next_cursor"] integerValue];
    set.total_number = [[dic objectForKey:@"total_number"] integerValue];
    NSArray *array = [dic mutableArrayValueForKey:@"statuses"];
    if (array.count != 0) {
        set.twitters = [NSMutableArray arrayWithCapacity:array.count];
        for (id dic in array) {
            Twitter *twitter = [Twitter objFormDictionary:dic];
            [set.twitters addObject:twitter];
        }
    }
    return set;
}

@end
