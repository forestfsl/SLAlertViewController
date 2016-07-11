//
//  JKPopViewController.m
//  jiankemall
//
//  Created by jianke on 16/6/25.
//  Copyright © 2016年 jianke. All rights reserved.
//

#import "SLAlertViewController.h"
#import "PureLayout.h"
#import "SLAlertFadeAnimation.h"
#import "SLAlertDropDownAnimation.h"
#import "SLAlertScaleFadeAnimation.h"

@interface SLAlertViewController ()

@end

@implementation SLAlertViewController


- (instancetype)init
{
    if (self = [super init]) {
        [self configureController];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self configureController];
    }
    return self;
}

//走的是这个方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self configureController];
    }
    return self;
}


-(void)configureController
{
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    _backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    _backgroundTapDismissEnable = NO;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [self addBackgroundView];
    [self configureAlertView];
    [self addSingleTapGesture];
    [self.view layoutIfNeeded];// this method is very important ,if you do not use,frame will not have alertView display as you want,use this method to force the layout of subViews before drawing
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_viewWillShowHandler) {
        _viewWillShowHandler(_alertView);
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_viewDidShowHandler) {
        _viewDidShowHandler(_alertView);
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_viewWillHideHandler) {
        _viewWillHideHandler(_alertView);
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_viewDidHideHandler) {
        _viewDidHideHandler(_alertView);
    }
}

-(void)addSingleTapGesture
{
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    singleTap.enabled = _backgroundTapDismissEnable;
    [_backgroundView addGestureRecognizer:singleTap];
    _singleTap = singleTap;
}

#pragma mark 手指点击事件
- (void)singleTap:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES];
}
-(void)setBackgroundTapDismissEnable:(BOOL)backgroundTapDismissEnable
{
    _backgroundTapDismissEnable = backgroundTapDismissEnable;
    _singleTap.enabled = backgroundTapDismissEnable;
}


-(void)addBackgroundView{
    if (_backgroundView == nil) {
        UIView *backgroundView = [[UIView alloc]init];
        backgroundView.backgroundColor = _backgroundColor;
        _backgroundView = backgroundView;
    }
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view insertSubview:_backgroundView atIndex:0];
    [_backgroundView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

}

-(void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = backgroundView;
    }else if (_backgroundView != backgroundView) {
        backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view insertSubview:backgroundView aboveSubview:_backgroundView];
        [backgroundView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        backgroundView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            backgroundView.alpha = 1;
        } completion:^(BOOL finished) {
            [_backgroundView removeFromSuperview];
            _backgroundView = backgroundView;
            [self addSingleTapGesture];
        }];
    }
}

- (void)configureAlertView
{
    if (_alertView == nil) {
        NSLog(@"%@: alertView is nil",NSStringFromClass([self class]));
        return;
    }
    _alertView.userInteractionEnabled = YES;
    [self.view addSubview:_alertView];
    _alertView.translatesAutoresizingMaskIntoConstraints = NO;
    switch (_preferredStyle) {
        case SLAlertControllerStyleActionSheet:
            [self layoutActionSheetStyleView];
            break;
        case SLAlertControllerStyleAlert:
            [self layoutAlertStyleView];
            break;
        default:
            break;
    }
}

-(void)layoutActionSheetStyleView
{
    //remove width constaint
    for (NSLayoutConstraint *constraint in _alertView.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth) {
            [_alertView removeConstraint:constraint];
        }
    }
    //add edge constraint
    [_alertView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    if (CGRectGetHeight(_alertView.frame) > 0) {
        //height
        [_alertView autoSetDimension:ALDimensionHeight toSize:CGRectGetHeight(_alertView.frame)];
    }
}

-(void)layoutAlertStyleView
{
    
    //CenterX
    [_alertView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.view];
    [_alertView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    //Width,height
    if (!CGSizeEqualToSize(_alertView.frame.size, CGSizeZero)) {
        [_alertView autoSetDimension:ALDimensionHeight toSize:CGRectGetHeight(_alertView.frame)];
        [_alertView autoSetDimension:ALDimensionWidth toSize:CGRectGetWidth(_alertView.frame)];
    }
    

}

+(instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(SLAlertControllerStyle)preferredStyle{
    return [[self alloc] initWithAlertView:alertView preferredStyle:preferredStyle transitionAnimation:SLAlertTransitionAnimationFade];
}


+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(SLAlertControllerStyle)preferredStyle transitionAnimation:(SLAlertTransitionAnimation)transitionAnimation
{
    return [[self alloc] initWithAlertView:alertView preferredStyle:preferredStyle transitionAnimation:transitionAnimation];
}


-(instancetype)initWithAlertView:(UIView *)alertView preferredStyle:(SLAlertControllerStyle)preferredStyle transitionAnimation:(SLAlertTransitionAnimation)transitionAnimation
{
    if (self = [self initWithNibName:nil bundle:nil]) {
        _alertView = alertView;
        _preferredStyle = preferredStyle;
        _transitionAnimation = transitionAnimation;
        
    }
    return self;
}

- (void)dismissViewControllerAnimated:(BOOL)animated
{
    [self dismissViewControllerAnimated:YES completion:self.dismissComplete];
}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self dismissViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



@implementation SLAlertViewController (TransitionAnimate)

#pragma mark -UIViewControllerTransitionDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    switch (self.transitionAnimation) {
        case SLAlertTransitionAnimationFade:
            return [SLAlertFadeAnimation alertAnimationIsPresenting:YES];
            break;
        case SLAlertTransitionAnimationDropDown:
            return [SLAlertDropDownAnimation alertAnimationIsPresenting:YES];
            break;
        case SLAlertTransitionAnimationScaleFade:
            return [SLAlertScaleFadeAnimation alertAnimationIsPresenting:YES];
            break;
        case SLAlertTransitionAnimationCustom:
            return [self.class alertAnimationIsPresenting:YES preferredStyle:self.preferredStyle];
            break;
        default:
            break;
    }
    return nil;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    switch (self.transitionAnimation) {
        case SLAlertTransitionAnimationFade:
            return [SLAlertFadeAnimation alertAnimationIsPresenting:NO];
            break;
        case SLAlertTransitionAnimationDropDown:
            return [SLAlertDropDownAnimation alertAnimationIsPresenting:NO];
            break;
        case SLAlertTransitionAnimationScaleFade:
            return [SLAlertScaleFadeAnimation alertAnimationIsPresenting:NO];
            break;
        case SLAlertTransitionAnimationCustom:
            return [self.class  alertAnimationIsPresenting:NO preferredStyle:self.preferredStyle];
            break;
        default:
            return nil;
            break;
    }
}

@end
