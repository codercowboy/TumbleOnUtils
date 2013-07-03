//
//  ListPickAddViewController.h
//  ReceiptKeeper
//
//  Created by Jason Baker on 3/11/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListPickAddViewController : UIViewController <UITextFieldDelegate>
@property (strong,nonatomic) NSString * itemDescription;
@property (strong,nonatomic) NSString * itemName;
@property (strong,nonatomic) NSString * itemNewName;
@property (strong,nonatomic) UIBarButtonItem * cancelButton;
@property (strong,nonatomic) UIBarButtonItem * saveButton;
@end
