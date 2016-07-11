//
//  SLAlertView.m
//  SLAlertViewController
//
//  Created by jianke on 16/6/25.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLAlertView.h"
#import "UIView+SLAlertView.h"
#import "PureLayout.h"
#import "ALView+PureLayout.h"


@interface SLAlertAction ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) SLAlertActionStyle style;
@property (nonatomic, copy) void (^handler)(SLAlertAction *);
@end


@implementation SLAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(SLAlertActionStyle)style handler:(void (^)(SLAlertAction *))handler
{
    return [[self alloc]initWithTitle:title style:style handler:handler];
}

- (instancetype)initWithTitle:(NSString *)title style:(SLAlertActionStyle)style handler:(void (^)(SLAlertAction *))handler
{
    if (self = [super init]) {
        _title = title;
        _style = style;
        _handler = handler;
        _enabled = YES;
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    SLAlertAction *action = [[self class]allocWithZone:zone];
    action.title = self.title;
    action.style = self.style;
    return action;
}

@end



@interface SLAlertView ()

// text content View
@property (nonatomic, weak) UIView *textContentView;
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UILabel *messageLabel;

@property (nonatomic, weak) UIView *textFeildContentView;
@property (nonatomic, weak) NSLayoutConstraint *textFeildTopConstraint;
@property (nonatomic, strong) NSMutableArray *textFeilds;
@property (nonatomic, strong) NSMutableArray *textFeildSeparateViews;

// button content View
@property (nonatomic, weak) UIView *buttonContentView;
@property (nonatomic, weak) NSLayoutConstraint *buttonTopConstraint;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *actions;

@end
// 屏幕宽度
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
// 屏幕高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kAlertViewWidth 280
#define kContentViewEdge 15
#define kContentViewSpace 10

#define kTextLabelSpace  6

#define kButtonTagOffset 1000
#define kButtonSpace     6
#define KButtonHeight    44

#define kTextFeildOffset 10000
#define kTextFeildHeight 29
#define kTextFeildEdge  8
#define KTextFeildBorderWidth 1

@implementation SLAlertView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configureProperty];
        [self addContentViews];
        [self addTextLabels];
    }
    return self;
}

#pragma mark -- configure
- (void)configureProperty
{
    self.backgroundColor = [UIColor whiteColor];
    _alertViewWidth = kAlertViewWidth;
    _contentViewSpace = kContentViewSpace;
    
    _textLabelSpace = kTextLabelSpace;
    _textLabelContentViewEdge = kContentViewEdge;
    
    _buttonHeight = KButtonHeight;
    _buttonSpace = kButtonSpace;
    _buttonContentViewEdge = kContentViewEdge;
    _buttonCornerRadius = 4.0;
    _buttonFont = [UIFont fontWithName:@"HelveticaNeue" size:18];;
    _buttonDefaultBgColor = [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1];
    _buttonCancleBgColor = [UIColor colorWithRed:127/255.0 green:140/255.0 blue:141/255.0 alpha:1];
    _buttonDestructiveBgColor = [UIColor colorWithRed:231/255.0 green:76/255.0 blue:60/255.0 alpha:1];
    
    _textFeildHeight = kTextFeildHeight;
    _textFeildEdge = kTextFeildEdge;
    _textFeildorderWidth = KTextFeildBorderWidth;
    _textFeildContentViewEdge = kContentViewEdge;
    
    _textFieldBorderColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    _textFieldBackgroudColor = [UIColor whiteColor];
    _textFieldFont = [UIFont systemFontOfSize:14];
    
    _buttons = [NSMutableArray array];
    _actions = [NSMutableArray array];
}

#pragma mark - add contentview

- (void)addContentViews
{
    UIView *textContentView = [[UIView alloc]init];
    [self addSubview:textContentView];
    _textContentView = textContentView;
    
    UIView *textFeildContentView = [[UIView alloc]init];
    [self addSubview:textFeildContentView];
    _textFeildContentView = textFeildContentView;
    
    UIView *buttonContentView = [[UIView alloc]init];
    buttonContentView.userInteractionEnabled = YES;
    [self addSubview:buttonContentView];
    _buttonContentView = buttonContentView;
}

- (void)addTextLabels
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_textContentView addSubview:titleLabel];
    _titleLable = titleLabel;
    
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    messageLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_textContentView addSubview:messageLabel];
    _messageLabel = messageLabel;
}

- (NSArray *)textFieldArray
{
    return _textFeilds;
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textFeild))configurationHandler
{
    if (_textFeilds == nil) {
        _textFeilds = [NSMutableArray array];
    }
    
    UITextField *textField = [[UITextField alloc]init];
    textField.tag = kTextFeildOffset + _textFeilds.count;
    textField.font = _textFieldFont;
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (configurationHandler) {
        configurationHandler(textField);
    }
    
    [_textFeildContentView addSubview:textField];
    [_textFeilds addObject:textField];
    
    if (_textFeilds.count > 1) {
        if (_textFeildSeparateViews == nil) {
            _textFeildSeparateViews = [NSMutableArray array];
        }
        UIView *separateView = [[UIView alloc]init];
        separateView.backgroundColor = _textFieldBorderColor;
        separateView.translatesAutoresizingMaskIntoConstraints = NO;
        [_textFeildContentView addSubview:separateView];
        [_textFeildSeparateViews addObject:separateView];
    }
    
    [self layoutTextFeilds];
}

-(void)layoutTextFeilds {
    UITextField *textFeild = _textFeilds.lastObject;
    
    if (_textFeilds.count == 1) {
        // setup textFeildContentView
        _textFeildContentView.backgroundColor = _textFieldBackgroudColor;
        _textFeildContentView.layer.masksToBounds = YES;
        _textFeildContentView.layer.cornerRadius = 4;
        _textFeildContentView.layer.borderWidth = _textFeildorderWidth;
        _textFeildContentView.layer.borderColor = _textFieldBorderColor.CGColor;
//        textFeild
        [textFeild autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [textFeild autoSetDimension:ALDimensionHeight toSize:_textFeildHeight];
    }else {
        // textFeild
        UITextField *lastSecondTextFeild = _textFeilds[_textFeilds.count - 2];
        [lastSecondTextFeild autoRemoveConstraintsAffectingView];
        [lastSecondTextFeild autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, _textFeildEdge, 0, _textFeildEdge) excludingEdge:ALEdgeBottom];
        [lastSecondTextFeild autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:textFeild];
        // separateview
        UIView *separateView = _textFeildSeparateViews[_textFeilds.count - 2];
        [separateView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [separateView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [lastSecondTextFeild autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:separateView];
        [separateView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:textFeild ];
        [separateView autoSetDimension:ALDimensionHeight toSize:_textFeildorderWidth ];
        [textFeild autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, _textFeildEdge, 0, _textFeildEdge) excludingEdge:ALEdgeTop];
        [textFeild autoSetDimension:ALDimensionHeight toSize:_textFeildHeight];


    }
}

- (void)addAction:(SLAlertAction *)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = _buttonCornerRadius;
    [button setTitle:action.title forState:UIControlStateNormal];
    button.titleLabel.font = _buttonFont;
    button.backgroundColor = [self buttonBgColorWithStyle:action.style];
    button.enabled = action.enabled;
    button.tag = kButtonTagOffset + _buttons.count;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonContentView addSubview:button];
    [_buttons addObject:button];
    [_actions addObject:action];

    
    if (_buttons.count == 1) {
        [self layoutContentViews];
        [self layoutTextLabels];
    }
    
    [self layoutButtons];
}

- (UIColor *)buttonBgColorWithStyle:(SLAlertActionStyle)style
{
    switch (style) {
        case SLAlertActionStyleDefault:
            return _buttonDefaultBgColor;
        case SLAlertActionStyleCancle:
            return _buttonCancleBgColor;
        case SLAlertActionStyleDestructive:
            return _buttonDestructiveBgColor;
            
        default:
            return nil;
    }
}

-(void)layoutContentViews
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self autoSetDimension:ALDimensionWidth toSize:_alertViewWidth];
      // textContentView
    _textContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [_textContentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(_contentViewSpace, _textLabelContentViewEdge, 0, _textLabelContentViewEdge) excludingEdge:ALEdgeBottom];
    //textFeildContentView
    _textFeildContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [_textFeildContentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_textContentView withOffset:_contentViewSpace];
    [_textFeildContentView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:_textFeildContentViewEdge];
    [_textFeildContentView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:_textFeildContentViewEdge];
   // buttonContentView
    _buttonContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [_buttonContentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_textFeildContentView withOffset:_contentViewSpace];
    [_buttonContentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, _buttonContentViewEdge, _contentViewSpace, _buttonContentViewEdge) excludingEdge:ALEdgeTop];
    
    
    
}
-(void)layoutTextLabels
{
    //title
    _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
    [_titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    //message
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_messageLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLable];
    [_messageLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
}
-(void)layoutButtons
{
        UIButton *button = _buttons.lastObject;
    if (_buttons.count == 1) {
        [button autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [button autoSetDimension:ALDimensionHeight toSize:_buttonHeight];
    }
    else if (_buttons.count == 2) {
        UIButton *firstButton = _buttons.firstObject;
        [firstButton autoRemoveConstraintsAffectingView];
        [firstButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTrailing];
        [button autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeading];
        [button autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:firstButton withOffset:_buttonSpace];
                [firstButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:button];
                [firstButton autoSetDimension:ALDimensionHeight toSize:_buttonHeight];
                [button autoSetDimension:ALDimensionHeight toSize:_buttonHeight];
            //这个方法理论上是可行，但是实际上错误，因为这个时候，根本就不知道_buttonContentView的高度尺寸，子视图也没有明确上下约束和父视图的关系，所以实现的效果有误差
//        [firstButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//        [button autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//        

  }
    else{
         if (_buttons.count == 3)
         {
        UIButton *firstButton = _buttons[0];
        UIButton *secondButton = _buttons[1];
        [firstButton autoRemoveConstraintsAffectingView];
        [secondButton autoRemoveConstraintsAffectingView];
        [firstButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [firstButton autoSetDimension:ALDimensionHeight toSize:_buttonHeight];

        [secondButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:firstButton withOffset:_buttonSpace];
        [secondButton autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [secondButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [secondButton autoSetDimension:ALDimensionHeight toSize:_buttonHeight];

        [button autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [button autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [button autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:secondButton withOffset:_buttonSpace];
        [button autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:_buttonSpace];
        [button autoSetDimension:ALDimensionHeight toSize:_buttonHeight];
             return;
         }
        UIButton *lastSecondButton = _buttons[_buttons.count - 2];
        for (NSLayoutConstraint *constraint in _buttonContentView.constraints) {
            if (constraint.firstAttribute ==NSLayoutAttributeBottom && constraint.firstItem == lastSecondButton) {
                [_buttonContentView removeConstraint:constraint];
            }
        }
        [button autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [button autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [button autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lastSecondButton withOffset:_buttonSpace];
        [button autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:_buttonSpace];
        [button autoSetDimension:ALDimensionHeight toSize:_buttonHeight];

    }
    

}
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    if (self = [super init]) {
        
        _titleLable.text = title;
        _messageLabel.text = message;
        
    }
    return self;
}
+(instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message
{
    return [[self alloc]initWithTitle:title message:message];
}


#pragma mark - action
- (void)actionButtonClicked:(UIButton *)button
{
    SLAlertAction *action = _actions[button.tag - kButtonTagOffset];
    [self hideView];
    if (action.handler) {
        action.handler(action);
    }
}

@end
