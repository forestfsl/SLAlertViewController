//
//  SLAlertDropDownAnimation.m
//  SLAlertViewController
//
//  Created by fengsonglin on 16/6/30.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLAlertDropDownAnimation.h"

@implementation SLAlertDropDownAnimation


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        return 0.5;
    }
    return 0.25;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    SLAlertViewController *alertController = (SLAlertViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    alertController.backgroundView.alpha = 0.0;
    switch (alertController.preferredStyle) {
        case SLAlertControllerStyleAlert:
            alertController.alertView.transform = CGAffineTransformMakeTranslation(0,-CGRectGetMaxY(alertController.alertView.frame));
            break;
        case SLAlertControllerStyleActionSheet:
            NSLog(@"don't support ActionSheet Style");
        default:
            break;
    }
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertController.view];
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
        alertController.backgroundView.alpha = 1.0;
        alertController.alertView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

-(void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    SLAlertViewController *alertController = (SLAlertViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [UIView animateWithDuration:0.25 animations:^{
        alertController.backgroundView.alpha = 0.0;
        switch (alertController.preferredStyle) {
            case SLAlertControllerStyleAlert:
                alertController.alertView.alpha = 0.0;
                alertController.alertView.transform = CGAffineTransformMakeScale(0.9, 0.9);
                break;
            case SLAlertControllerStyleActionSheet:
                NSLog(@"don't support ActionSheet style");
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
