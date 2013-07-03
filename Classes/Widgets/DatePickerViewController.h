//
//  DatePickerViewController.h
//  ReceiptKeeper
//
//  Created by Jason Baker on 2/24/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) NSDate * date;
@property (strong,nonatomic) IBOutlet UITextField * dateTextField;
@property (nonatomic) BOOL animatePickerShow;
@property (nonatomic) BOOL changeDateAsPickerChanges;
@end
