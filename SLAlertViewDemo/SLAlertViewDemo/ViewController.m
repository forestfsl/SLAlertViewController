//
//  ViewController.m
//  SLAlertViewController
//
//  Created by jianke on 16/6/25.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "ViewController.h"
#import "SLAlertView.h"
#import "SLAlertViewController.h"
#import "ShareView.h"
#import "UIView+SLAlertView.h"
#import "SLAlertViewController+BlurEffects.h"
#import "SettingModelView.h"
#import "UIView+SLAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showAlertViewAction:(id)sender {
    SLAlertView *alertView = [SLAlertView alertViewWithTitle:@"SLAlertView" message:@"This is a message, alert view containt text and textfiled. "];
    
    [alertView addAction:[SLAlertAction actionWithTitle:@"取消" style:SLAlertActionStyleCancle handler:^(SLAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    // 弱引用alertView 否则 会循环引用
    __typeof (alertView) __weak weakAlertView = alertView;
    [alertView addAction:[SLAlertAction actionWithTitle:@"确定" style:SLAlertActionStyleDestructive handler:^(SLAlertAction *action) {
        
        NSLog(@"%@",action.title);
        for (UITextField *textField in weakAlertView.textFieldArray) {
            NSLog(@"%@",textField.text);
        }
    }]];
    
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入账号";
    }];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入密码";
    }];
    
    SLAlertViewController *alertController = [SLAlertViewController alertControllerWithAlertView:alertView preferredStyle:SLAlertControllerStyleAlert];
    alertController.backgroundTapDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
    //can do something here
//    [alertController setViewWillShowHandler:^(UIView *alertView) {
//        NSLog(@"ViewWillShow");
//    }];
//    [alertController setViewDidHideHandler:^(UIView *alertView) {
//        NSLog(@"ViewDidShow");
//    }];
//    [alertController setViewWillHideHandler:^(UIView *alertView) {
//        NSLog(@"ViewWillHide");
//    }];
//    [alertController setViewDidHideHandler:^(UIView *alertView) {
//        NSLog(@"ViewDidHide");
//    }];
    
}

- (IBAction)showActionSheetAction:(id)sender {
    SLAlertView *alertView = [SLAlertView alertViewWithTitle:@"SLAlertView" message:@"This is a message ,the alert style is actionsheet."];
  //  SLAlertView *alertView = [[SLAlertView alloc]init];
    [alertView addAction:[SLAlertAction actionWithTitle:@"摸我" style:SLAlertActionStyleDefault handler:^(SLAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    [alertView addAction:[SLAlertAction actionWithTitle:@"打我" style:SLAlertActionStyleDefault handler:^(SLAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    [alertView addAction:[SLAlertAction actionWithTitle:@"骂我" style:SLAlertActionStyleDefault handler:^(SLAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    [alertView addAction:[SLAlertAction actionWithTitle:@"吻我" style:SLAlertActionStyleDefault handler:^(SLAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];

    [alertView addAction:[SLAlertAction actionWithTitle:@"取消" style:SLAlertActionStyleDefault handler:^(SLAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    SLAlertViewController *alertController = [SLAlertViewController alertControllerWithAlertView:alertView preferredStyle:SLAlertControllerStyleActionSheet];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)blurEffectAlertViewAction:(id)sender {
    ShareView *shareView = [ShareView createViewFromNib];
    SLAlertViewController *alertController = [SLAlertViewController alertControllerWithAlertView:shareView preferredStyle:SLAlertControllerStyleAlert];
    //blur effect
    [alertController setBlurEffectWithView:self.view];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)dropdownAnimationAction:(id)sender {
    SLAlertView *alertView = [SLAlertView alertViewWithTitle:@"SLAlertView" message:@"This is message,the alert view constaint dropdown animation"];
    [alertView addAction:[SLAlertAction actionWithTitle:@"取消" style:SLAlertActionStyleCancle handler:^(SLAlertAction *action) {
        NSLog(@"dropdownAnimationAction:%@",action.title);
    }]];
    SLAlertViewController *alertController = [SLAlertViewController alertControllerWithAlertView:alertView preferredStyle:SLAlertControllerStyleAlert transitionAnimation:SLAlertTransitionAnimationDropDown];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)customActionSheetAction:(id)sender {
    SettingModelView *settingModelView = [SettingModelView createViewFromNib];
    SLAlertViewController *alertController = [SLAlertViewController alertControllerWithAlertView:settingModelView preferredStyle:SLAlertControllerStyleActionSheet];
    alertController.backgroundTapDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)showAlertViewInWindowAction:(id)sender {
    SLAlertView *alertView = [SLAlertView alertViewWithTitle:@"SLAlertView" message:@"if you thing you can,you can!"];
    [alertView addAction:[SLAlertAction actionWithTitle:@"取消" style:SLAlertActionStyleCancle handler:^(SLAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    [alertView addAction:[SLAlertAction actionWithTitle:@"确定" style:SLAlertActionStyleDestructive handler:^(SLAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    //first method ,the result as dropdownAnimationAction
//    SLAlertViewController *alertViewController =[SLAlertViewController alertControllerWithAlertView:alertView preferredStyle:SLAlertControllerStyleAlert transitionAnimation:SLAlertTransitionAnimationDropDown];
//    [self presentViewController:alertViewController animated:YES completion:nil];
    
    //second method,the result as showAlertViewAction
//    SLAlertViewController *alertController = [SLAlertViewController alertControllerWithAlertView:alertView preferredStyle:SLAlertControllerStyleAlert];
//    [self presentViewController:alertController animated:YES completion:nil];
    
    //the third method
    //All of the above two methods are required to pop up the SLAlertViewController,the next method is directly added to the window;
    [alertView showInWindowWithOriginy:200 backgroundTapDismissEnable:YES];
    
}

- (IBAction)customViewInWindowAction:(id)sender {
    ShareView *shareView = [ShareView createViewFromNib];
    [shareView showInWindow];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
