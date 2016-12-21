//
//  BaseViewController.h
//  WeiBo
//
//  Created by Luobu on 21/10/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)runOnMainThread:(dispatch_block_t)block;

@end
