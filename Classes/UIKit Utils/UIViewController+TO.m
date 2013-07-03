//
//  ViewController+CC.m
//  ReceiptKeeper
//
//  Created by Jason Baker on 2/24/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import "UIViewController+TO.h"

@implementation UIViewController (TO)

- (void) setNavBackButtonTitle:(NSString*)title {
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:self action:@selector(navBackButtonTapped)];
}

- (void) navBackButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

+ (UIViewController *) vcFromNib:(NSString*)className {
    Class clz = NSClassFromString(className);
    UIViewController * instance = [clz alloc];
    return [instance initWithNibName:className bundle:nil];
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

- (void) setNavLeftItem:(UIBarButtonItem*)item {
    self.navigationItem.leftBarButtonItem = item;
}
- (void) setNavRightItem:(UIBarButtonItem*)item {
    self.navigationItem.rightBarButtonItem = item;
}

- (void) handleNavLeftTap:(id)sender {
    [self popOrDismissAnimated];
}
- (void) handleNavRighttTap:(id)sender {
    [self popOrDismissAnimated];
}
@end
