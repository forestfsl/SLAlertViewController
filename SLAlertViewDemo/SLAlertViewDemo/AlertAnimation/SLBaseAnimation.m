//
//  SLBaseAnimation.m
//  SLAlertViewController
//
//  Created by fengsonglin on 16/6/27.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLBaseAnimation.h"

@interface SLBaseAnimation ()

@property (nonatomic, assign) BOOL isPresenting;
@end

@implementation SLBaseAnimation

- (instancetype)initWithIsPresenting:(BOOL)isPresenting
{
    if (self = [super init]) {
        self.isPresenting = isPresenting;
    }
    return self;
}

+(instancetype)alertAnimationIsPresenting:(BOOL)isPresenting
{
    return [[self alloc]initWithIsPresenting:isPresenting];
}

+(instancetype)alertAnimationIsPresenting:(BOOL)isPresenting preferredStyle:(SLAlertControllerStyle)preferredStyle
{
    return [[self alloc]initWithIsPresenting:isPresenting];
}
//override this method
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (_isPresenting) {
        [self presentAnimateTransition:transitionContext];
    }else {
        [self dismissAnimateTransition:transitionContext];
    }
}

-(void)presentAnimateTransition:(id<UIViewControllerAnimatedTransitioning>)transitionContext
{
    
}

-(void)dismissAnimateTransition:(id<UIViewControllerAnimatedTransitioning>)transitionContext
{
    
}



@end
