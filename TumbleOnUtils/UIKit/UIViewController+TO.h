/*
 
 UIViewController+TO
 
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

#import <UIKit/UIKit.h>

@interface UIViewController (TO)
- (void) setNavBackButtonTitle:(NSString*)title;
- (void) push:(UIViewController *)vc;
- (void) pushAnimated:(UIViewController*)vc;
- (void) pushModal:(UIViewController*)vc;
- (void) pushModalInNavControllerAnimated:(UIViewController*)vc;
- (void) pushModalInNavController:(UIViewController*)vc;
- (UINavigationController*) wrapInNavController:(UIViewController*)vc;
- (void) pushModalAnimated:(UIViewController*)vc;
- (void) popOrDismiss;
- (void) popOrDismissAnimated;
+ (UIViewController *) vcFromNib:(NSString*)className;

- (void) setNavLeftItem:(UIBarButtonItem*)item;
- (void) setNavRightItem:(UIBarButtonItem*)item;
- (void) handleNavLeftTap:(id)sender;
- (void) handleNavRighttTap:(id)sender;
@end

#define vcFromNib(className2) [UIViewController vcFromNib:className2]