//
//  NSString+Font.m
//  WeiBo
//
//  Created by Luobu on 21/12/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import "NSString+Font.h"

@implementation NSString (Font)

- (CGFloat)heightWhitFont:(UIFont *)font andWidth:(CGFloat)width {
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil].size.height + 1;

}

@end
