/*
 
 TOCurrencyTextField
 
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


//based largely on this: http://www.thepensiveprogrammer.com/2010/03/customizing-uitextfield-formatting-for.html

#import "TOCurrencyTextField.h"
#import "Foundation+TO.h"

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

- (long long) value {
    return [self.currentNumber longLongValue];
}

- (void)setValue:(long long)value {
    self.currentNumber = [NSMutableString stringWithString:[[NSNumber numberWithLongLong:value] stringValue]];
    [self renderValue];
}

- (void) renderValue {
    NSLog(@"Current string: %@", self.currentNumber);
    long long value = [self.currentNumber longLongValue];
    int cents = value % 100;
    long long dollars = value / 100;
    NSString * withThousands = [[NSNumber numberWithLongLong:dollars] formatWithThousands];
    [self setText:[NSString stringWithFormat:@"$%@.%02d", withThousands, cents]];
}


@end
