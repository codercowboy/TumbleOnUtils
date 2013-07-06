//
//  TOWidgetDemoViewController.m
//  TumbleOnUtils
//
//  Created by Jason Baker on 7/5/13.
//  Copyright (c) 2013 Jason Baker. All rights reserved.
//

#import "TOWidgetDemoViewController.h"

@interface TOWidgetDemoViewController ()

@end

@implementation TOWidgetDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TOCurrencyTextField * currencyTextField = [[TOCurrencyTextField alloc] init];
    [currencyTextField frameResizeToWidth:200 height:20];
    [self addView:currencyTextField withClass:[currencyTextField class]];
    [self addWidgetWithName:@"TODatePickerViewController"];
}


@end
