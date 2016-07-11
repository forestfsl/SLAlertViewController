//
//  SLAlertViewController+BlurEffects.h
//  SLAlertViewController
//
//  Created by fengsonglin on 16/6/29.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLAlertViewController.h"

typedef NS_ENUM(NSUInteger ,BlurEffectStyle) {
    BlurEffectStyleLight,
    BlurEffectStyleExtraLight,
    BlurEffectStyleDarkEffect,
};

@interface SLAlertViewController (BlurEffects)

- (void)setBlurEffectWithView:(UIView *)view;
- (void)setBlurEffectWithView:(UIView *)view style:(BlurEffectStyle)blurStyle;
- (void)setBlurEffectWithView:(UIView *)view effectTintColor:(UIColor *)effectTintColor;

@end
