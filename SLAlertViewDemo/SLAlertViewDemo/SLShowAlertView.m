//
//  SLShowAlertView.m
//  SLAlertViewController
//
//  Created by fengsonglin on 16/6/29.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLShowAlertView.h"
#import "PureLayout.h"

//current window
#define kCurrentWindow [[UIApplication sharedApplication].windows firstObject]

@interface SLShowAlertView ()

@property (nonatomic, weak) UITapGestureRecognizer *singleTap;

@end

@implementation SLShowAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _backgroundTapDismissEnable = NO;
        _alertViewEdging = 15;
        [self addBackgroundView];
        [self addSingleGesture];
    }
    return self;
}

#pragma mark --add background
- (void)addBackgroundView
{
    if (_backgroundView == nil) {
        UIView *backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _backgroundView = backgroundView;
    }
    [self insertSubview:_backgroundView atIndex:0];
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [_backgroundView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}


#pragma mark - add Gesture
- (void)addSingleGesture
{
    self.userInteractionEnabled = YES;
    //single tap
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    //add the event responder
    [_backgroundView addGestureRecognizer:singleTap];
    _singleTap = singleTap;
    
}

#pragma mark finger click event
- (void) singleTap:(UITapGestureRecognizer *)sender
{
    [self hide];
}

- (void)hide
{
    if (self.subviews) {
        [UIView animateWithDuration:0.3 animations:^{
            _alertView.transform = CGAffineTransformScale(_alertView.transform, 0.1, 0.1);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)show
{
    if (self.superview == nil) {
        [kCurrentWindow addSubview:self];
    }
    self.alpha = 0;
    _alertView.transform = CGAffineTransformScale(_alertView.transform, 0.1, 0.1);
    [UIView animateWithDuration:0.3 animations:^{
        _alertView.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}
- (instancetype)initWithAlertView:(UIView *)tipView
{
    if (self = [self initWithFrame:CGRectZero]) {
        [self addSubview:tipView];
        _alertView = tipView;
    }
    return self;
}


-(void)setBackgroundTapDismissEnable:(BOOL)backgroundTapDismissEnable
{
    _backgroundTapDismissEnable = backgroundTapDismissEnable;
    _singleTap.enabled = backgroundTapDismissEnable;
}
+(instancetype)alertViewWithView:(UIView *)alertView
{
    return [[self alloc]initWithAlertView:alertView];
}

- (void)didMoveToSuperview
{
    if (self.superview) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [self layoutAlertView];
    }
}

- (void)layoutAlertView {
    _alertView.translatesAutoresizingMaskIntoConstraints = NO;
    //centerX,centerY
    [_alertView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    NSLayoutConstraint *alertViewCenterYConstraint = [_alertView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    //Width,height
    if (!CGSizeEqualToSize(_alertView.frame.size, CGSizeZero)) {
        [_alertView autoSetDimension:ALDimensionHeight toSize:CGRectGetHeight(_alertView.frame)];
        [_alertView autoSetDimension:ALDimensionWidth toSize:CGRectGetWidth(_alertView.frame)];
    }
    
    if (_alertViewOriginY > 0) {
        [_alertView layoutIfNeeded];
      alertViewCenterYConstraint.constant = _alertViewOriginY - (CGRectGetHeight(self.superview.frame) - CGRectGetHeight(_alertView.frame))/2;
    }
}


+ (void)showAlertViewWithView:(UIView *)alertView
{
    [self showAlertViewWithView:alertView backgroundTapDismissEnable:NO];
}

+(void)showAlertViewWithView:(UIView *)alertView backgroundTapDismissEnable:(BOOL)backgroundTapDismissEnable
{
    SLShowAlertView *showTipView = [self alertViewWithView:alertView];
    showTipView.backgroundTapDismissEnable = backgroundTapDismissEnable;
    [showTipView show];
}

+(void)showAlertViewWithView:(UIView *)alertView originY:(CGFloat)originY
{
    [self showAlertViewWithView:alertView originY:originY backgroundTapDismissEnable:NO];
}
+(void)showAlertViewWithView:(UIView *)alertView originY:(CGFloat)originY backgroundTapDismissEnable:(BOOL)backgroundTapDismissEnable
{
    SLShowAlertView *showTipView = [self alertViewWithView:alertView];
    showTipView.alertViewOriginY = originY;
    showTipView.backgroundTapDismissEnable = backgroundTapDismissEnable;
    [showTipView show];
}


@end
