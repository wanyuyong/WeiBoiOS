//
//  TwitterSet.h
//  WeiBo
//
//  Created by Luobu on 27/10/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Twitter.h"

@interface TwitterSet : NSObject

@property (nonatomic) NSUInteger previous_cursor;
@property (nonatomic) NSUInteger next_cursor;
@property (nonatomic) NSUInteger total_number;
@property (strong, nonatomic) NSMutableArray *twitters;

+(TwitterSet *)objFormDictionary:(NSDictionary *)dic;

@end
