//
//  UIKit+CC.h
//  RoofRats
//
//  Created by Jason Baker on 6/1/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIAlertView (TO)
+ (UIAlertView*) showSimpleAlert:(NSString*)message;
+ (UIAlertView*) showSimpleNoYesAlert:(NSString*)message alertViewDelegate:(id<UIAlertViewDelegate>)alertViewDelegate;
+ (UIAlertView*) showSimpleCancelOkAlert:(NSString*)message alertViewDelegate:(id<UIAlertViewDelegate>)alertViewDelegate;
@end

@interface UIViewController (TO)
- (void) fixForNon4Inch;
@end

@interface UIView (TO)
@property (nonatomic, retain) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic) CGFloat borderWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;
- (void) removeAllSubviews;
-(void)animateBounceTo:(CGPoint)to delay:(NSTimeInterval)delay;
-(void)animateBounceTo:(CGPoint)to;
- (void) setGradientBackgroundFromColor:(UIColor*)color1 toColor:(UIColor*)color2;
- (void) setGradientBackgroundFromColors:(NSArray*)colors;
- (UIView *) findChildWithClass:(Class)classToFind;
- (UIWebView *) findChildUIWebView;
- (UIImageView *) findChildUIImageView;
- (UIScrollView *) findChildUIScrollView;
+ (UIView *) fullScreenShadowBackground;
+ (void) hideUIWebViewShadow:(UIWebView *)webView;
+ (int) getTouchTapCount:(UIEvent *) event;
+ (BOOL) isSingleTap:(UIEvent *) event;
+ (BOOL) isDoubleTap:(UIEvent *) event;

@end

@interface UIButton (TO)
+ (UIButton*) buttonWithTitle:(NSString*)title tapSelector:(SEL)tapSelector parent:(NSObject*)parent frame:(CGRect)frame;
@end

#define UIBUTTON(title,sel,parent2,frame2) [UIButton buttonWithTitle:title tapSelector:sel parent:parent2 frame:frame2]


@interface UIBarButtonItem (TO)
@property (weak,nonatomic) UIColor * titleColor;
@end

#define BarButtonItem(titleParam, actionParam) [[UIBarButtonItem alloc] initWithTitle:titleParam style:UIBarButtonItemStyleBordered target:self action:actionParam]
#define BarButtonFlexibleSpace [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]
#define BarButtonFixedSpace [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil]


@interface UIViewController (TO)
@end

#define screenHeight [[UIScreen mainScreen] bounds].size.height
#define screenIs4Inch (screenHeight == 568)
#define screenIs3dot5Inch (screenHeight == 480)
