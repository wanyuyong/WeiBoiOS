//
//  MusicPlayControlView.m
//  WeiBo
//
//  Created by Luobu on 24/11/2016.
//  Copyright © 2016 Luobu. All rights reserved.
//

#import "MusicPlayControlView.h"

@interface MusicPlayControlView () <CAAnimationDelegate>

@property(strong, nonatomic) CAKeyframeAnimation *bezierForwardAnimation;
@property(strong, nonatomic) CABasicAnimation *enlargedAnimation;
@property(strong, nonatomic) CABasicAnimation *shrinkAnimation;
@property(strong, nonatomic) CABasicAnimation *stretchAnimation;
@property(strong, nonatomic) NSMutableArray *musicArray;

@end

@implementation MusicPlayControlView 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return [[[MusicPlayControlView internalBundle] loadNibNamed:@"MusicPlayControlView" owner:self options:nil] firstObject];
}

+ (NSBundle *)internalBundle {
    return [NSBundle bundleForClass: [MusicPlayControlView class]];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _playBtn.layer.cornerRadius = _playBtn.frame.size.width / 2;
    _playBtn.layer.masksToBounds = YES;
    _playBtn.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.3f].CGColor;
    _playBtn.layer.borderWidth = 4;
    _playBtn.userInteractionEnabled = YES;
    _playBtn.backgroundColor = MUSIC_CONTROLLER_ACTIVATE;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playBtnClick:)];
    [_playBtn addGestureRecognizer:singleTap];
    
    _enlargedView.layer.cornerRadius = _enlargedView.frame.size.width / 2;
    _enlargedView.layer.masksToBounds = YES;
    _enlargedView.userInteractionEnabled = YES;
    
    UIImage *thumbImage = [UIImage imageNamed:@"thumb"];
    [_slider setThumbImage:thumbImage forState:UIControlStateNormal];
    
    _pauseBtn.userInteractionEnabled = YES;
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pauseBtnClick:)];
    [_pauseBtn addGestureRecognizer:singleTap];
    
    _playControllerContainer.backgroundColor = MUSIC_CONTROLLER_DEFAULT;
}

- (void)playBtnClick:(UITapGestureRecognizer *)gestureRecognizer
{
    [self doBezierForwardAnimation];
    [self doFadeOutAnimation];
}

- (void)pauseBtnClick:(UITapGestureRecognizer *)gestureRecognizer
{
    _playControllerContainer.backgroundColor = MUSIC_CONTROLLER_DEFAULT;
    _musicNameBig.hidden = NO;
    _singerName.hidden = NO;
    _enlargedView.hidden = NO;
    _musicNameSmall.hidden = YES;
    _slider.hidden = YES;
    _buttonsLay.hidden = YES;
    [self doShrinkAnimation];
}

#pragma Animations
- (void)doFadeOutAnimation
{
    NSLog(@"--------------doFadeOutAnimation---------------");
    [UIView animateWithDuration:.6 animations:^(void){
        _musicNameBig.alpha = 0;
        _singerName.alpha = 0;
    }];
}

- (void)doFadeInAnimation
{
    NSLog(@"--------------doFadeOutAnimation---------------");
    [UIView animateWithDuration:.6 animations:^(void){
        _musicNameBig.alpha = 1;
        _singerName.alpha = 1;
    }];
}

- (void)doBezierForwardAnimation
{
    NSLog(@"--------------doBezierForwardAnimation---------------");
    CFTimeInterval duration = .6;
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:_playBtn.center];
    [bezierPath addCurveToPoint:CGPointMake(SCREEN_WIDTH / 2, self.bounds.size.height - _playControllerContainer.frame.size.height / 2) controlPoint1:CGPointMake(SCREEN_WIDTH + 40, _playBtn.center.y) controlPoint2:CGPointMake(SCREEN_WIDTH + 40, self.bounds.size.height * 1.08f)];
    
//    [self drawBezierPath:bezierPath];
    
    //贝赛尔曲线
    _bezierForwardAnimation = [CAKeyframeAnimation animation];
    _bezierForwardAnimation.keyPath = @"position";
    _bezierForwardAnimation.duration = duration;
    _bezierForwardAnimation.path = bezierPath.CGPath;
    _bezierForwardAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _bezierForwardAnimation.removedOnCompletion = NO;
    _bezierForwardAnimation.fillMode = kCAFillModeForwards;
    _bezierForwardAnimation.delegate = self;
   
    [_playBtn.layer addAnimation:_bezierForwardAnimation forKey:@"bezierForwardAnimation"];
}

- (void)doReverseBezierForwardAnimation
{
    NSLog(@"--------------doReverseBezierForwardAnimation---------------");
    CFTimeInterval duration = .6;
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(SCREEN_WIDTH / 2, self.bounds.size.height - _playControllerContainer.frame.size.height / 2)];
    [bezierPath addCurveToPoint:_playBtn.center controlPoint1:CGPointMake(SCREEN_WIDTH + 40, self.bounds.size.height * 1.08f) controlPoint2:CGPointMake(SCREEN_WIDTH + 40, _playBtn.center.y)];
    
    //    [self drawBezierPath:bezierPath];
    
    
    //贝赛尔曲线
    _bezierForwardAnimation = [CAKeyframeAnimation animation];
    _bezierForwardAnimation.keyPath = @"position";
    _bezierForwardAnimation.duration = duration;
    _bezierForwardAnimation.path = bezierPath.CGPath;
    _bezierForwardAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _bezierForwardAnimation.removedOnCompletion = NO;
    _bezierForwardAnimation.fillMode = kCAFillModeForwards;
    _bezierForwardAnimation.delegate = self;
    
    [_playBtn.layer addAnimation:_bezierForwardAnimation forKey:@"reverseBezierForwardAnimation"];
}

- (void)drawBezierPath:(UIBezierPath *)bezierPath
{
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 1.0f;
    [self.layer addSublayer:pathLayer];
}

- (void)doEnlargedAnimation
{
     NSLog(@"--------------doEnlargedAnimation---------------");
    _enlargedAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    _enlargedAnimation.duration = .5;
    _enlargedAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    _enlargedAnimation.toValue = [NSNumber numberWithFloat:10.0];
    _enlargedAnimation.delegate = self;
    _enlargedAnimation.removedOnCompletion = NO;
    _enlargedAnimation.fillMode = kCAFillModeForwards;
    _enlargedAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.11 :0.28 :0.25 :1.00];
    [_enlargedView.layer addAnimation:_enlargedAnimation forKey:@"enlargedAnimation"];
}

- (void)doShrinkAnimation
{
    NSLog(@"--------------doShrinkAnimation---------------");
    _shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    _shrinkAnimation.duration = .5;
    _shrinkAnimation.fromValue = [NSNumber numberWithFloat:10];
    _shrinkAnimation.toValue = [NSNumber numberWithFloat:1];
    _shrinkAnimation.delegate = self;
    _shrinkAnimation.removedOnCompletion = NO;
    _shrinkAnimation.fillMode = kCAFillModeForwards;
    [_enlargedView.layer addAnimation:_shrinkAnimation forKey:@"shrinkAnimation"];
}

- (void)doStretchAnimation
{
    NSLog(@"--------------doStretchAnimation---------------");
    _stretchAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    _stretchAnimation.duration = 1;
    _stretchAnimation.fromValue = [NSNumber numberWithFloat:0];
    _stretchAnimation.toValue = [NSNumber numberWithFloat:1.0];
    _stretchAnimation.removedOnCompletion = YES;
    _stretchAnimation.fillMode = kCAFillModeRemoved;
    _stretchAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.00 :0.99 :0.00 :1.00];
    
    [_slider.layer addAnimation:_stretchAnimation forKey:@"stretchAnimation"];
    [_musicNameSmall.layer addAnimation:_stretchAnimation forKey:@"stretchAnimation"];
    [_buttonsLay.layer addAnimation:_stretchAnimation forKey:@"stretchAnimation"];
    
    
}

- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"--------------animationDidStop---------------");
    if ([anim isEqual:[_playBtn.layer animationForKey:@"bezierForwardAnimation"]]) {
        _playBtn.hidden = YES;
        _enlargedView.hidden = NO;
        [self doEnlargedAnimation];
    } else if ([anim isEqual:[_enlargedView.layer animationForKey:@"enlargedAnimation"]]) {
        _musicNameBig.hidden = YES;
        _singerName.hidden = YES;
        _musicNameSmall.hidden = NO;
        _slider.hidden = NO;
        _buttonsLay.hidden = NO;
        _enlargedView.hidden = YES;
        _playControllerContainer.backgroundColor = MUSIC_CONTROLLER_ACTIVATE;
        [self doStretchAnimation];
    } else if ([anim isEqual:[_enlargedView.layer animationForKey:@"shrinkAnimation"]]) {
        _enlargedView.hidden = YES;
        _playBtn.hidden = NO;
        [self doReverseBezierForwardAnimation];
    } else if ([anim isEqual:[_playBtn.layer animationForKey:@"reverseBezierForwardAnimation"]]) {
        [self doFadeInAnimation];
    }
}

#pragma play
- (void)play
{
   NSURL *musicURL = [NSURL URLWithString:@"https://static.lehe.com/higo/feseTT/m/vip/summary/Labels-Or-Love.mp4"];
    
}


@end
