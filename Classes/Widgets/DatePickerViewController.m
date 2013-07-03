//
//  DatePickerViewController.m
//  ReceiptKeeper
//
//  Created by Jason Baker on 2/24/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()
@property (strong,nonatomic) NSDate * innerDate;
@property (strong,nonatomic) IBOutlet UIDatePicker * datePicker;
@property (strong,nonatomic) IBOutlet UIStepper * dateStepper;
@property (strong,nonatomic) IBOutlet UIView * inputAccessoryView;
@end

@implementation DatePickerViewController

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
