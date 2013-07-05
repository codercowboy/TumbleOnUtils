/*
 
 TODatePickerViewController
 
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

#import "TODatePickerViewController.h"

@interface TODatePickerViewController ()
@property (strong,nonatomic) NSDate * innerDate;
@property (strong,nonatomic) IBOutlet UIDatePicker * datePicker;
@property (strong,nonatomic) IBOutlet UIStepper * dateStepper;
@property (strong,nonatomic) IBOutlet UIView * inputAccessoryView;
@end

@implementation TODatePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateTextField.inputView = self.datePicker;
    self.dateTextField.inputAccessoryView = self.inputAccessoryView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction) stepperChanged:(id)sender {
    @synchronized(self) {
        int day = 24 * 60 * 60;
        int stepAmount = day * (int) self.dateStepper.value;
        NSDate * newDate = [self.innerDate dateByAddingTimeInterval:stepAmount];
        [self setDate:newDate];
        self.dateStepper.value = 0;
    }
}

- (IBAction) pickerDateChanged:(id)sender {
    if (self.changeDateAsPickerChanges) {
        [self setDate:self.datePicker.date];
    }
}

- (IBAction) doneChoosingDate:(id)sender {
    [self setDate:self.datePicker.date];
    [self.dateTextField resignFirstResponder];
}

- (IBAction) cancelDatePicker:(id)sender {
    [self.dateTextField resignFirstResponder];
}

- (void)setDate:(NSDate *)date {
    if (date == nil) {
        date = [NSDate date];
    }
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    self.dateTextField.text = [formatter stringFromDate:date];
    self.innerDate = date;
    self.datePicker.date = date;
}

- (NSDate*) date {
    return self.innerDate;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

@end
