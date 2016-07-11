//
//  SLAlertView.h
//  SLAlertViewController
//
//  Created by jianke on 16/6/25.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SLAlertActionStyle) {
    SLAlertActionStyleDefault,
    SLAlertActionStyleCancle,
    SLAlertActionStyleDestructive,
};

@interface SLAlertAction : NSObject<NSCopying>

+ (instancetype)actionWithTitle:(NSString *)title style:(SLAlertActionStyle)style handler:(void (^)(SLAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) SLAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@end

@interface SLAlertView : UIView


@property (nonatomic, strong, readonly) NSArray *textFieldArray;

@property (nonatomic, assign) CGFloat alertViewWidth;

// contentView space custom
@property (nonatomic, assign) CGFloat contentViewSpace;

// textLabel custom
@property (nonatomic, assign) CGFloat textLabelSpace;
@property (nonatomic, assign) CGFloat textLabelContentViewEdge;

// button custom
@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, assign) CGFloat buttonSpace;
@property (nonatomic, assign) CGFloat buttonContentViewEdge;
@property (nonatomic, assign) CGFloat buttonCornerRadius;
@property (nonatomic, strong) UIFont *buttonFont;
@property (nonatomic, strong) UIColor *buttonDefaultBgColor;
@property (nonatomic, strong) UIColor *buttonCancleBgColor;
@property (nonatomic, strong) UIColor *buttonDestructiveBgColor;

// textFeild custom
@property (nonatomic, strong) UIColor *textFieldBorderColor;
@property (nonatomic, strong) UIColor *textFieldBackgroudColor;
@property (nonatomic, strong) UIFont *textFieldFont;
@property (nonatomic, assign) CGFloat textFeildHeight;
@property (nonatomic, assign) CGFloat textFeildEdge;
@property (nonatomic, assign) CGFloat textFeildorderWidth;
@property (nonatomic, assign) CGFloat textFeildContentViewEdge;


+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message;

- (void)addAction:(SLAlertAction *)action;

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;
@end
