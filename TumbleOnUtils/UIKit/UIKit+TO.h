/*
 
 UIKit+TO
 
 ---
 
 This code comes from TumbleOnUtils, which is an open-source collection of
 iOS utilities developed for TumbleOn and other projects.
 
 https://github.com/codercowboy/TumbleOnUtils/
 
 Authors
 * Jason Baker (jason@onejasonforsale.com)
 * Adam Zacharski (zacharski@gmail.com)
 
 TumbleOnUtils is licensed with the Apache license. For details, see:
 
 https://github.com/codercowboy/TumbleOnUtils/blob/master/LICENSE.md
 
 Copyright (c) 2012-2013, Pocket Sized Giraffe, LLC. All rights reserved.
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIAlertView (TO)
+ (UIAlertView*) showSimpleAlert:(NSString*)message;
+ (UIAlertView*) showSimpleNoYesAlert:(NSString*)message alertViewDelegate:(id<UIAlertViewDelegate>)alertViewDelegate;
+ (UIAlertView*) showSimpleCancelOkAlert:(NSString*)message alertViewDelegate:(id<UIAlertViewDelegate>)alertViewDelegate;
+ (UIAlertView*) showSimpleAlert:(NSString*)message buttonTitles:(NSArray*)buttonTitles
               alertViewDelegate:(id<UIAlertViewDelegate>)alertViewDelegate;
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
@end

@interface UIEvent (TO)
@property (nonatomic, readonly) int touchTapCount;
@property (nonatomic, readonly) BOOL isSingleTap;
@property (nonatomic, readonly) BOOL isDoubleTap;
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