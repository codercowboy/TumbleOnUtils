//
//  UIKit+CC.m
//  RoofRats
//
//  Created by Jason Baker on 6/1/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import "UIKit+TO.h"
#import "UIView+FrameUtils.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIAlertView (TO)

+ (UIAlertView*) showSimpleAlert:(NSString*)message {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil
                                           cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    return alert;
}

+ (UIAlertView*) showSimpleNoYesAlert:(NSString*)message alertViewDelegate:(id<UIAlertViewDelegate>)alertViewDelegate {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:alertViewDelegate
                                           cancelButtonTitle:nil otherButtonTitles:@"NO", @"YES", nil];
    [alert show];
    return alert;

}

+ (UIAlertView*) showSimpleCancelOkAlert:(NSString*)message alertViewDelegate:(id<UIAlertViewDelegate>)alertViewDelegate {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:alertViewDelegate
                                           cancelButtonTitle:nil otherButtonTitles:@"CANCEL", @"OK", nil];
    [alert show];
    return alert;
}


@end

@implementation UIViewController (TO)

- (void)fixForNon4Inch {
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
//        UIView * oldView = self.view;
//        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
//        [self.view addSubview:oldView];
//        [oldView frameMoveToX:-44];
//        oldView.backgroundColor = [UIColor redColor];
//        self.view.backgroundColor = [UIColor blueColor];
        for (UIView * v in [self.view subviews]) {
            [v frameMoveByXDelta:-44];
        }
    }
}

@end

@implementation UIView (TO)

- (void) removeAllSubviews {
    for (UIView * v in self.subviews) {
        [v removeFromSuperview];
    }
}

-(void)animateBounceTo:(CGPoint)to delay:(NSTimeInterval)delay
{
    CGPoint firstStop = CGPointMake(to.x-(self.frame.origin.x-to.x)*.1, to.y-(self.frame.origin.y-to.y)*.1);
    
    [UIView animateWithDuration:.3 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^(void){
        [self frameMoveToPosition:firstStop];
    } completion:^(BOOL b){
        [UIView animateWithDuration:.2 animations:^{
            [self frameMoveToPosition:to];
        }];
    }];
}
-(void)animateBounceTo:(CGPoint)to
{
    [self animateBounceTo:to delay:0];
}

@dynamic borderWidth, borderColor, cornerRadius;

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = [borderColor CGColor];
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (void) setGradientBackgroundFromColor:(UIColor*)color1 toColor:(UIColor*)color2 {
    [self setGradientBackgroundFromColors:@[color1,color2]];
}

- (void) setGradientBackgroundFromColors:(NSArray*)colors {
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0,0,self.frame.size.width, self.frame.size.height);;
    NSMutableArray * gradientColors = [NSMutableArray array];
    for (UIColor * color in colors) {
        [gradientColors addObject:(id)[color CGColor]];
    }
    gradientLayer.colors = gradientColors;
    [self.layer insertSublayer:gradientLayer atIndex:0];
    self.backgroundColor = [UIColor clearColor];
}

- (UIView *) findChildWithClass:(Class)classToFind {
    return [UIView findChildClass:classToFind parentView:self];
}

+ (UIView *) findChildClass:(Class)classToFind parentView:(UIView *)parentView {
    for (UIView *checkView in [parentView subviews] ) {
        if ([checkView isKindOfClass:classToFind]) {
            return checkView;
        }
    }
    return nil;
}

- (UIWebView *) findChildUIWebView {
    return (UIWebView *) [self findChildWithClass:[UIWebView class]];
}

- (UIImageView *) findChildUIImageView {
    return (UIImageView *) [self findChildWithClass:[UIImageView class]];
}

- (UIScrollView *) findChildUIScrollView {
    return (UIScrollView *) [self findChildWithClass:[UIScrollView class]];
}


+ (UIView *) fullScreenShadowBackground {
    UIView * grayBackground = [[UIView alloc] initWithFrame:[FrameUtils frameIpadLandscape]];
    grayBackground.backgroundColor = [UIColor blackColor];
    grayBackground.alpha = 0.5f;
    grayBackground.opaque = NO;
    return grayBackground;
}

+ (void) hideUIWebViewShadow:(UIWebView *)webView {
    for (UIView* shadowView in [[webView findChildUIScrollView] subviews]) {
        //UIScrollView inside a webview has several UIImageView
        // subviews, that need to all be hidden..
        if ([shadowView isKindOfClass:[UIImageView class]]) {
            [shadowView setHidden:YES];
        }
    }
}

+ (int) getTouchTapCount:(UIEvent *) event  {
    //---get all touches on the screen---
    NSSet *allTouches = [event allTouches];
	
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    return [touch tapCount];
    //---compare the number of touches on the screen---
}

+ (BOOL) isSingleTap:(UIEvent *) event {
    return [self getTouchTapCount:event] == 1;
}

+ (BOOL) isDoubleTap:(UIEvent *) event {
    return [self getTouchTapCount:event] == 2;
}


@end

@implementation UIButton (CC)

+ (UIButton*) buttonWithTitle:(NSString*)title tapSelector:(SEL)tapSelector parent:(NSObject *)parent frame:(CGRect)frame {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = frame;
    if (parent != nil) {
        [button addTarget:parent action:tapSelector forControlEvents:UIControlEventTouchUpInside];
        if ([parent isKindOfClass:[UIViewController class]]) {
            [((UIViewController*)parent).view addSubview:button];
        }
        if ([parent isKindOfClass:[UIView class]]) {
            [((UIView*)parent) addSubview:button];
        }
    }
    return button;
}

@end

@implementation UIBarButtonItem (TO)
- (void)setTitleColor:(UIColor *)titleColor {
    [self setTitleTextAttributes:@{UITextAttributeTextColor:titleColor} forState:UIControlStateNormal];
}

- (UIColor *)titleColor {
    return [[self titleTextAttributesForState:UIControlStateNormal] objectForKey:UITextAttributeTextColor];
}

@end