//
//  UIView+SLAlertView.m
//  SLAlertViewController
//
//  Created by fengsonglin on 16/6/29.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "UIView+SLAlertView.h"
#import "SLAlertViewController.h"
#import "SLShowAlertView.h"

@implementation UIView (SLAlertView)

+(instancetype)createViewFromNibName:(NSString *)nibName
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [nib objectAtIndex:0];
}

+(instancetype)createViewFromNib
{
    return [self createViewFromNibName:NSStringFromClass(self.class)];
}

#pragma mark -- show in window

- (void)showInWindow
{
    [self showInWindowWithBackgroundTapDismissEnable:NO];
}

- (void)showInWindowWithBackgroundTapDismissEnable:(BOOL)backgroundTapDismissEnable
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [SLShowAlertView showAlertViewWithView:self backgroundTapDismissEnable:backgroundTapDismissEnable];
}

- (void)showInWindowWithOriginy:(CGFloat)OriginY
{
    [self showInWindowWithOriginy:OriginY backgroundTapDismissEnable:NO];
}

- (void)showInWindowWithOriginy:(CGFloat)OriginY backgroundTapDismissEnable:(BOOL)backgroundTapDismissEnable
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [SLShowAlertView showAlertViewWithView:self originY:OriginY backgroundTapDismissEnable:backgroundTapDismissEnable];
    
}

-(void)hideView
{
    if ([self isShowInAlertController]) {
        [self hideInController];
    }else if ([self isShowInWindow]) {
        [self hideInWindow];
    }
}
-(BOOL)isShowInWindow
{
    if (self.superview && [self.superview isKindOfClass:[SLShowAlertView class]]) {
        return YES;
    }
    return NO;
}

- (void)hideInWindow
{
    if ([self isShowInWindow]) {
        [(SLShowAlertView *)self.superview hide];
    }else {
        NSLog(@"self.superView is nil,or isn't SLShowAlertView");
    }
}

- (BOOL)isShowInAlertController
{
    UIViewController *viewController = self.viewController;
    if (viewController && [viewController isKindOfClass:[SLAlertViewController class]]) {
        return  YES;
    }
    return NO;
}

-(UIViewController *)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(void)hideInController
{
    if ([self isShowInAlertController]) {
        [(SLAlertViewController *)self.viewController dismissViewControllerAnimated:YES];
    }else {
        NSLog(@"selg.viewController is nil,or isn't SLAlertViewController");
    }
}

@end
