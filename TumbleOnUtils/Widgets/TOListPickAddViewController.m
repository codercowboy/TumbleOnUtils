/*
 
 TOListPickAddViewController
 
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

#import "TOListPickAddViewController.h"
#import "UIKit+TO.h"

@interface TOListPickAddViewController ()
@property (strong,nonatomic) IBOutlet UITextField * textField;
@property (strong,nonatomic) IBOutlet UINavigationItem * navTitle;
@end

@implementation TOListPickAddViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.navTitle.title = [NSString stringWithFormat:@"Add %@", self.itemDescription];
    if (self.itemName != nil) {
        self.navTitle.title = [NSString stringWithFormat:@"Rename %@", self.itemDescription];
        self.textField.text = self.itemName;
    }
    if (self.cancelButton == nil) {
        self.cancelButton = BarButtonItem(@"Cancel", @selector(cancel));
    }
    if (self.saveButton == nil) {
        self.saveButton = BarButtonItem(@"Save", @selector(save));
    }
    self.navTitle.leftBarButtonItem = self.cancelButton;
    self.navTitle.rightBarButtonItem = self.saveButton;
    [self.textField becomeFirstResponder];
}

- (void) cancel {
    [self dismissViewControllerAnimated:YES completion:NO];
}

- (void) save {
    self.itemNewName = self.textField.text;
    if ([self.itemNewName length] == 0) {
        self.itemNewName = nil;
    }
    [self dismissViewControllerAnimated:YES completion:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self save];
    return YES;
}

@end
