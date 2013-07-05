/*
 
 UIViewController+TO
 
 ---
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com), 2013.
 
 The latest version of this code is available here:
 
 - https://bitbucket.org/tumbleon/tumbleon-utils
 
 This code is licensed under the Apache license, a non-viral open source license
 that lets you use this code freely within your own projects without requiring
 your project itself to also be open source. More information about the Apache
 license is here:
 
 - http://en.wikipedia.org/wiki/Apache_license
 
 Copyright (c) 2013, Pocket Sized Giraffe, LLC. All rights reserved.
 
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
