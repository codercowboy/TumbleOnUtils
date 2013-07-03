//
//  ViewController+CC.h
//  ReceiptKeeper
//
//  Created by Jason Baker on 2/24/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

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