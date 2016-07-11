//
//  SLShowAlertView.h
//  SLAlertViewController
//
//  Created by fengsonglin on 16/6/29.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLShowAlertView : UIView
@property (nonatomic, weak, readonly) UIView *alertView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, assign) BOOL backgroundTapDismissEnable;//default NO
@property (nonatomic, assign) CGFloat alertViewOriginY; // default center Y
@property (nonatomic, assign) CGFloat alertViewEdging; // default 15

+ (void)showAlertViewWithView:(UIView *)alertView;
+ (void)showAlertViewWithView:(UIView *)alertView backgroundTapDismissEnable:(BOOL)backgroundTapDismissEnable;
+ (void)showAlertViewWithView:(UIView *)alertView originY:(CGFloat)originY;
+ (void)showAlertViewWithView:(UIView *)alertView originY:(CGFloat)originY backgroundTapDismissEnable:(BOOL)backgroundTapDismissEnable;
+ (instancetype)alertViewWithView:(UIView *)alertView;

-(void)show;
-(void)hide;
@end
