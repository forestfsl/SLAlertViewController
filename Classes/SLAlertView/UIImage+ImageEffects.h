//
//  UIImage+ImageEffects.h
//  SLAlertViewController
//
//  Created by fengsonglin on 16/6/29.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageEffects)

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

@end


@interface UIImage (SnapshotImage)

+ (UIImage *)snapshotImageWithView:(UIView *)view;

@end