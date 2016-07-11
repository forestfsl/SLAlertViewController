//
//  SLBaseAnimation.h
//  SLAlertViewController
//
//  Created by fengsonglin on 16/6/27.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SLAlertViewController.h"

@interface SLBaseAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign,readonly) BOOL isPresenting; //present,dismiss

+(instancetype)alertAnimationIsPresenting:(BOOL)isPresenting;
+(instancetype)alertAnimationIsPresenting:(BOOL)isPresenting preferredStyle:(SLAlertControllerStyle)preferredStyle;

//override transition time
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;
//override present
- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
