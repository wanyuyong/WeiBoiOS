//
//  TwitterCell.h
//  WeiBo
//
//  Created by Luobu on 01/11/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Twitter.h"

@interface TwitterCell : UITableViewCell

@property(strong, nonatomic)UIImageView *avatar;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *createTimeLabel;
@property(strong, nonatomic)UILabel *contentLabel;
@property(strong, nonatomic)UIImageView *picView;

@property(strong, nonatomic)UIView *originalArea;
@property(strong, nonatomic)UILabel *originalNameLabel;
@property(strong, nonatomic)UILabel *originalContentLabel;
@property(strong, nonatomic)UIImageView *originalPicView;

@property(strong, nonatomic)UIView *bottomBar;
@property(strong, nonatomic)UILabel *forwardLabel;
@property(strong, nonatomic)UILabel *commentLabel;
@property(strong, nonatomic)UILabel *likeLabel;

- (void)setTwitter:(Twitter *)twitter;

@end
