//
//  ListPickAddViewController.m
//  ReceiptKeeper
//
//  Created by Jason Baker on 3/11/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import "ListPickAddViewController.h"
#import "UIKit+TO.h"

@interface ListPickAddViewController ()
@property (strong,nonatomic) IBOutlet UITextField * textField;
@property (strong,nonatomic) IBOutlet UINavigationItem * navTitle;
@end

@implementation ListPickAddViewController

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
