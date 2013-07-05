/*
 
 TODatePickerViewController
 
 ---
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com), Feb 2013.
 
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
