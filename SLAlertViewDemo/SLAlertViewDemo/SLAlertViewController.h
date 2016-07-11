//
//  JKPopViewController.h
//  jiankemall
//
//  Created by jianke on 16/6/25.
//  Copyright © 2016年 jianke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,SLAlertControllerStyle){
    SLAlertControllerStyleAlert = 0,
    SLAlertControllerStyleActionSheet
};

typedef NS_ENUM(NSInteger , SLAlertTransitionAnimation){
    SLAlertTransitionAnimationFade = 0,
    SLAlertTransitionAnimationScaleFade,
    SLAlertTransitionAnimationDropDown,
    SLAlertTransitionAnimationCustom
};

@interface SLAlertViewController : UIViewController

@property (nonatomic,strong,readonly) UIView *alertView;
@property (nonatomic,strong) UIColor *backgroundColor;
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,assign,readonly) SLAlertControllerStyle preferredStyle;
@property (nonatomic,assign,readonly) SLAlertTransitionAnimation transitionAnimation;
@property (nonatomic, weak) UITapGestureRecognizer *singleTap;
@property (nonatomic, copy) void (^dismissComplete)(void);
@property (nonatomic, assign) BOOL backgroundTapDismissEnable; //default NO 是否允许点击背景view

@property (copy, nonatomic) void (^viewWillShowHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewDidShowHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewWillHideHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewDidHideHandler)(UIView *alertView);


+(instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(SLAlertControllerStyle)preferredStyle;
+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(SLAlertControllerStyle)preferredStyle transitionAnimation:(SLAlertTransitionAnimation)transitionAnimation;

- (void)dismissViewControllerAnimated:(BOOL)animated;
@end

//Transition Animate
@interface SLAlertViewController  (TransitionAnimate)<UIViewControllerTransitioningDelegate>

@end
