//
//  SLAlertViewController+BlurEffects.m
//  SLAlertViewController
//
//  Created by fengsonglin on 16/6/29.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLAlertViewController+BlurEffects.h"
#import "UIImage+ImageEffects.h"

@implementation SLAlertViewController (BlurEffects)

- (void)setBlurEffectWithView:(UIView *)view
{
    [self setBlurEffectWithView:view style:BlurEffectStyleLight];
}

- (void)setBlurEffectWithView:(UIView *)view style:(BlurEffectStyle)blurStyle
{
    //time consuming task(gdc)
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *snapshotImage = [UIImage snapshotImageWithView:view];
        UIImage *blurImage = [self blurImageWithSnapshotImage:snapshotImage style:blurStyle];
        //Notify the main thread to refresh
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *blurImageView = [[UIImageView alloc]initWithImage:blurImage]
            ;
            self.backgroundView = blurImageView;
        });
    });
}

-(void)setBlurEffectWithView:(UIView *)view effectTintColor:(UIColor *)effectTintColor
{
    //time consuming task
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *snapshotImage = [UIImage snapshotImageWithView:view];
        UIImage *blurImage = [snapshotImage applyTintEffectWithColor:effectTintColor];
        //Notify the main thread to refresh
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *blutImageView = [[UIImageView alloc]initWithImage:blurImage];
            self.backgroundView = blutImageView;
        });
    });
}


- (UIImage *)blurImageWithSnapshotImage:(UIImage *)snapshotImage style:(BlurEffectStyle)blurStyle
{
    switch (blurStyle) {
        case BlurEffectStyleLight:
            return [snapshotImage applyLightEffect];
            break;
        case BlurEffectStyleDarkEffect:
            return [snapshotImage applyDarkEffect];
        case BlurEffectStyleExtraLight:
            return [snapshotImage applyExtraLightEffect];
        default:
            return nil;
            break;
    }
}
@end
