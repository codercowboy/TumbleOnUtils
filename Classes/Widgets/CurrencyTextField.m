//
//  CurrencyTextField.m
//  ReceiptKeeper
//
//  Created by Jason Baker on 2/24/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

//based largely on this: http://www.thepensiveprogrammer.com/2010/03/customizing-uitextfield-formatting-for.html

#import "CurrencyTextField.h"

@interface CurrencyTextField ()
@property (strong, nonatomic) NSNumberFormatter * currencyFormatter;
@property (strong, nonatomic) NSMutableString * currentNumber;
@property (strong, nonatomic) NSCharacterSet * unallowedCharacters;
@end

@implementation CurrencyTextField

- (void)awakeFromNib {
    [self initialize];
}

- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void) initialize {
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
