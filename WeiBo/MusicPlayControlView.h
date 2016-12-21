//
//  MusicPlayControlView.h
//  WeiBo
//
//  Created by Luobu on 24/11/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayControlView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *previousBtn;
@property (weak, nonatomic) IBOutlet UIImageView *nextBtn;
@property (weak, nonatomic) IBOutlet UIImageView *pauseBtn;
@property (weak, nonatomic) IBOutlet UILabel *singerName;
@property (weak, nonatomic) IBOutlet UILabel *musicNameBig;
@property (weak, nonatomic) IBOutlet UILabel *musicNameSmall;
@property (weak, nonatomic) IBOutlet UIView *buttonsLay;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIImageView *playBtn;
@property (weak, nonatomic) IBOutlet UIView *playControllerContainer;
@property (weak, nonatomic) IBOutlet UIView *enlargedView;
@property (weak, nonatomic) IBOutlet UIImageView *musicBg;

@end
