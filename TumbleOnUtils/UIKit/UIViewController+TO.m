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

#import "UIViewController+TO.h"

@implementation UIViewController (TO)

- (void) setNavLeftButtonTitle:(NSString*)title {
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:self action:@selector(handleNavLeftTap:)];
}

- (void) setNavRightButtonTitle:(NSString*)title {
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:self action:@selector(handleNavRightTap:)];
}

- (void) setNavLeftItem:(UIBarButtonItem*)item {
    self.navigationItem.leftBarButtonItem = item;
}
- (void) setNavRightItem:(UIBarButtonItem*)item {
    self.navigationItem.rightBarButtonItem = item;
}

- (void) handleNavLeftTap:(id)sender {
    [self popOrDismissAnimated];
}
- (void) handleNavRightTap:(id)sender {
    [self popOrDismissAnimated];
}


- (void) push:(UIViewController *)vc {
    [self.navigationController pushViewController:vc animated:NO];
}

- (void) pushAnimated:(UIViewController*)vc {
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) pushModal:(UIViewController*)vc {
    [self presentViewController:vc animated:NO completion:nil];
}

- (void) pushModalAnimated:(UIViewController*)vc {
    [self presentViewController:vc animated:YES completion:nil];
}

- (void) pushModalInNavController:(UIViewController*)vc {
    UINavigationController * navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    navVC.modalTransitionStyle = vc.modalTransitionStyle;
    [self presentViewController:navVC animated:NO completion:nil];
}

- (UINavigationController*) wrapInNavController:(UIViewController*)vc {
    UINavigationController * navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    navVC.modalTransitionStyle = vc.modalTransitionStyle;
    return navVC;
}

- (void) pushModalInNavControllerAnimated:(UIViewController*)vc {
    UINavigationController * navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    navVC.modalTransitionStyle = vc.modalTransitionStyle;
    [self presentViewController:navVC animated:YES completion:nil];
}

- (void) popOrDismiss {
    [self popOrDismissInternal:NO];
}

- (void) popOrDismissAnimated {
    [self popOrDismissInternal:YES];
}

- (void) popOrDismissInternal:(BOOL)animated {
    if (self.navigationController != nil) {
        UIViewController * rootVC = [self.navigationController.viewControllers objectAtIndex:0];
        if (rootVC == self) {
            [self dismissViewControllerAnimated:animated completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:animated];
        }
    } else {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}

@end
