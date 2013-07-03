/*
 
 UIKit+TO
 
 ---
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com), 2012.
 
 The latest version of this code is available here:
 
 - https://bitbucket.org/tumbleon/tumbleon-utils
 
 This code is licensed under the Apache license, a non-viral open source license
 that lets you use this code freely within your own projects without requiring
 your project itself to also be open source. More information about the Apache
 license is here:
 
 - http://en.wikipedia.org/wiki/Apache_license
 
 Copyright (c) 2012, Pocket Sized Giraffe, LLC. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or other
 materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those of
 the authors and should not be interpreted as representing official policies, either
 expressed or implied.
 
 */

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

#define screenHeight [[UIScreen mainScreen] bounds].size.height
#define screenIs4Inch (screenHeight == 568)
#define screenIs3dot5Inch (screenHeight == 480)
