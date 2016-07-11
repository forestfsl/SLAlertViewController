//
//  SLAlertFadeAnimation.m
//  SLAlertViewController
//
//  Created by fengsonglin on 16/6/27.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLAlertFadeAnimation.h"

@implementation SLAlertFadeAnimation


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        return 0.5;
    }
    return 0.25;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    SLAlertViewController *alertVC = (SLAlertViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    alertVC.backgroundView.alpha = 0.0;
    switch (alertVC.preferredStyle) {
        case SLAlertControllerStyleAlert:
            alertVC.alertView.alpha = 0.0;
            alertVC.alertView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            break;
         case SLAlertControllerStyleActionSheet:
            alertVC.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertVC.alertView.frame));
        default:
            break;
    }
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertVC.view];
    [UIView animateWithDuration:0.25 animations:^{
        alertVC.backgroundView.alpha = 1.0;
        switch (alertVC.preferredStyle) {
            case SLAlertControllerStyleAlert:
                alertVC.alertView.alpha = 1.0;
                alertVC.alertView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                break;
            case SLAlertControllerStyleActionSheet:
                alertVC.alertView.transform = CGAffineTransformMakeTranslation(0, -10);
                
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            alertVC.alertView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }];
}

-(void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    SLAlertViewController *alertVc = (SLAlertViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [UIView animateWithDuration:0.25 animations:^{
        alertVc.backgroundView.alpha = 0.0;
        switch (alertVc.preferredStyle) {
            case SLAlertControllerStyleAlert:
                alertVc.alertView.alpha = 0.0;
                alertVc.alertView.transform = CGAffineTransformMakeScale(0.9, 0.9);
                break;
             case SLAlertControllerStyleActionSheet:
                alertVc.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertVc.alertView.frame));
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
@end
