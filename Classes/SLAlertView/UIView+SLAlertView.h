//
//  UIView+SLAlertView.h
//  SLAlertViewController
//
//  Created by fengsonglin on 16/6/29.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SLAlertView)


- (UIViewController *)viewController;
+ (instancetype)createViewFromNib;
+ (instancetype)createViewFromNibName:(NSString *)nibName;


#pragma mark ---hide
- (void)hideView;

#pragma mark - show in window
- (void)showInWindow;
- (void)showInWindowWithBackgroundTapDismissEnable:(BOOL)backgroundTapDismissEnable;
- (void)showInWindowWithOriginy:(CGFloat)OriginY;
- (void)showInWindowWithOriginy:(CGFloat)OriginY backgroundTapDismissEnable:(BOOL)backgroundTapDismissEnable;

@end
