//
//  JSONUtility.m
//  WeiBo
//
//  Created by Luobu on 01/11/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import "JSONUtility.h"

@implementation JSONUtility

+ (NSString*)dataToJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
