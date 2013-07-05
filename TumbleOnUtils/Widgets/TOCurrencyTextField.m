/*
 
 TOCurrencyTextField
 
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

//based largely on this: http://www.thepensiveprogrammer.com/2010/03/customizing-uitextfield-formatting-for.html

#import "TOCurrencyTextField.h"

@interface TOCurrencyTextField ()
@property (strong, nonatomic) NSNumberFormatter * currencyFormatter;
@property (strong, nonatomic) NSMutableString * currentNumber;
@property (strong, nonatomic) NSCharacterSet * unallowedCharacters;
@end

@implementation TOCurrencyTextField

- (void)awakeFromNib {
    [self setup];
}

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    self.unallowedCharacters = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    self.keyboardType = UIKeyboardTypeDecimalPad;
    self.delegate = self;
    self.currencyFormatter = [[NSNumberFormatter alloc] init];
    [self.currencyFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [self.currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [self.currencyFormatter setMaximumFractionDigits:2];
    [self.currencyFormatter setLocale:[NSLocale currentLocale]];
    self.currentNumber = [[NSMutableString alloc] initWithString:@"0"];
    [self renderValue];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    self.currentNumber = [[NSMutableString alloc] initWithString:@"0"];
    [self renderValue];
    return NO;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([string length] == 0){ //backspace
        if ([self.currentNumber length] == 0) {
            return NO;
        }
        int index = [self.currentNumber length] -1;
        self.currentNumber = [NSMutableString stringWithString:[self.currentNumber substringToIndex:index]];
    } else {
        string = [[string componentsSeparatedByCharactersInSet:self.unallowedCharacters]componentsJoinedByString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"." withString:@""];
        if (string == nil) {
            string = @"";
        }
        [self.currentNumber appendString:string];
    }

    [self renderValue];
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (int) value {
    return [self.currentNumber intValue];
}

- (void)setValue:(int)value {
    self.currentNumber = [NSMutableString stringWithString:[[NSNumber numberWithInt:value] stringValue]];
    [self renderValue];
}

- (void) renderValue {
    NSLog(@"Current string: %@", self.currentNumber);
    int value = [self.currentNumber intValue];
    int cents = value % 100;
    int dollars = value / 100;
    [self setText:[NSString stringWithFormat:@"$%d.%02d", dollars, cents]];
}


@end
