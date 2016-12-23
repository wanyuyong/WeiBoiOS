//
//  TwitterCell.m
//  WeiBo
//
//  Created by Luobu on 01/11/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import "TwitterCell.h"
#import "Masonry.h"
#import "NSString+Font.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation TwitterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _avatar = [[UIImageView alloc] init];
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = AVATAR_WIDTH / 2 ;
        [self.contentView addSubview:_avatar];
        [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(AVATAR_WIDTH, AVATAR_WIDTH));
            make.top.and.left.equalTo(self.contentView).offset(PADDING);
        }];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = lARGE_FONT_THIN;
        _nameLabel.textColor = COLOR_LABEL;
        _nameLabel.numberOfLines = 1;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_avatar);
            make.left.mas_equalTo(_avatar.mas_right).offset(PADDING);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-PADDING);
        }];
        
        _createTimeLabel = [[UILabel alloc] init];
        _createTimeLabel.font = SMALL_FONT_THIN;
        _createTimeLabel.textColor = COLOR_SMALL_TEXT;
        [self.contentView addSubview:_createTimeLabel];
        [_createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_avatar.mas_bottom);
            make.left.mas_equalTo(_avatar.mas_right).offset(PADDING);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-PADDING);
        }];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = MEDIUM_FONT_THIN;
        _contentLabel.textColor = COLOR_NORMAL_TEXT;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_avatar.mas_bottom).offset(PADDING);
            make.left.equalTo(_avatar);
            make.right.equalTo(self.contentView).offset(-PADDING);
        }];
        
        _picView = [[UIImageView alloc] init];
        _picView.contentMode = UIViewContentModeScaleAspectFill;
        _picView.clipsToBounds = YES;
        [self.contentView addSubview:_picView];
        [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_contentLabel.mas_bottom).offset(PADDING);
            make.left.equalTo(_avatar);
            make.right.equalTo(self.contentView).offset(-PADDING);
        }];
        
        //Original Twitter Area
        _originalArea = [[UIView alloc] init];
        _originalArea.backgroundColor = COLOR_LIGHT_BG;
        [self.contentView addSubview:_originalArea];
        [_originalArea mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.contentView);
        }];
        
        _originalNameLabel = [[UILabel alloc] init];
        _originalNameLabel.font = MEDIUM_FONT_THIN;
        _originalNameLabel.textColor = COLOR_AT_NAME;
        _originalNameLabel.numberOfLines = 1;
        [_originalArea addSubview:_originalNameLabel];
        [_originalNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(_originalArea).offset(PADDING);
            make.right.equalTo(_originalArea).offset(-PADDING);
        }];
        
        _originalContentLabel = [[UILabel alloc] init];
        _originalContentLabel.font = MEDIUM_FONT_THIN;
        _originalContentLabel.textColor = COLOR_NORMAL_TEXT;
        _originalContentLabel.numberOfLines = 0;
        [_originalArea addSubview:_originalContentLabel];
        [_originalContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_originalNameLabel.mas_bottom).offset(PADDING);
            make.left.and.right.equalTo(_originalNameLabel);
        }];
        
        _originalPicView = [[UIImageView alloc] init];
        _originalPicView.contentMode = UIViewContentModeScaleAspectFill;
        _originalPicView.clipsToBounds = YES;
        [_originalArea addSubview:_originalPicView];
        [_originalPicView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_originalContentLabel.mas_bottom).offset(PADDING);
            make.left.and.right.equalTo(_originalContentLabel);
            make.bottom.equalTo(_originalArea).offset(-PADDING);
        }];
        
        _bottomBar = [[UIView alloc] init];
        [self.contentView addSubview:_bottomBar];
        [_bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.top.mas_equalTo(_originalArea.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, BOTTOM_BAR_HEIGHT));
        }];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = COLOR_LIGHT_BG;
        [_bottomBar addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.equalTo(_bottomBar);
            make.width.equalTo(_bottomBar);
            make.height.mas_equalTo(1);
        }];
        _forwardLabel = [[UILabel alloc] init];
        _forwardLabel.text = @"Forward";
        _forwardLabel.textAlignment = NSTextAlignmentCenter;
        _forwardLabel.font = SMALL_FONT_THIN;
        _forwardLabel.textColor = COLOR_SMALL_TEXT;
        [_bottomBar addSubview:_forwardLabel];
        [_forwardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_bottomBar);
            make.width.mas_equalTo(SCREEN_WIDTH / 3);
            make.left.equalTo(_bottomBar);
        }];
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.text = @"Comment";
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        _commentLabel.font = SMALL_FONT_THIN;
        _commentLabel.textColor = COLOR_SMALL_TEXT;
        [_bottomBar addSubview:_commentLabel];
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_bottomBar);
            make.left.mas_equalTo(_forwardLabel.mas_right);
            make.size.equalTo(_forwardLabel);
        }];
        _likeLabel = [[UILabel alloc] init];
        _likeLabel.text = @"Like";
        _likeLabel.textAlignment = NSTextAlignmentCenter;
        _likeLabel.font = SMALL_FONT_THIN;
        _likeLabel.textColor = COLOR_SMALL_TEXT;
        [_bottomBar addSubview:_likeLabel];
        [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_bottomBar);
            make.left.mas_equalTo(_commentLabel.mas_right);
            make.size.equalTo(_forwardLabel);
        }];
        
    }
    return self;
}

- (void)initViews {
    _avatar.image = nil;
    _nameLabel.text = nil;
    _createTimeLabel.text = nil;
    _contentLabel.text = nil;
    _picView.image = nil;
    _originalNameLabel.text = nil;
    _originalContentLabel.text = nil;
    _originalPicView.image = nil;
    _picView.hidden = YES;
    _originalArea.hidden = YES;
    _originalPicView.hidden = YES;
}

- (void)setTwitter:(Twitter *)twitter {
    
    [self initViews];
    
    _nameLabel.text = twitter.user.name;
    _contentLabel.text = twitter.text;
    _createTimeLabel.text = twitter.created_at;
    _originalNameLabel.text = [NSString stringWithFormat:@"From %@", twitter.original_twitter.user.name];
    _originalContentLabel.text = twitter.original_twitter.text;
    
    [_avatar sd_setImageWithURL:[NSURL URLWithString:twitter.user.avatar_large]];
    
    if (twitter.bmiddle_pic) {
        [_picView sd_setImageWithURL:[NSURL URLWithString:twitter.bmiddle_pic]];
        _picView.hidden = NO;
        CGFloat picW = SCREEN_WIDTH - (PADDING * 2);
        [_picView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(picW, picW * IMG_SCALE));
        }];
    } else {
        [_picView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeZero);
        }];
    }
    
    if (twitter.original_twitter) {
        _originalArea.hidden = NO;
        [_originalArea mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_picView.mas_bottom).offset(twitter.bmiddle_pic ? PADDING : 0);
            make.left.and.right.equalTo(self.contentView);
        }];
        
        if (twitter.original_twitter.bmiddle_pic) {
            [_originalPicView sd_setImageWithURL:[NSURL URLWithString:twitter.original_twitter.bmiddle_pic]];
             _originalPicView.hidden = NO;
            CGFloat originalPicW = SCREEN_WIDTH - (PADDING * 2);
            [_originalPicView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(originalPicW, originalPicW * IMG_SCALE));
                make.bottom.equalTo(_originalArea).offset(-PADDING);
            }];
        } else {
            [_originalPicView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeZero);
                make.bottom.equalTo(_originalArea).offset(0);
            }];
        }
  
    } else {
        [_originalArea mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_picView.mas_bottom).offset(twitter.bmiddle_pic ? PADDING : 0);
            make.size.mas_equalTo(CGSizeZero);
        }];

    }
}

@end
