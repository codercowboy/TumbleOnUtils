//
//  UIKeyboardListener.m
//  TumbleOn
//
//  Created by Adam Zacharski on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIKeyboardListener.h"

@implementation UIKeyboardListener

+ (UIKeyboardListener *) sharedInstance {
    static UIKeyboardListener * sListener;    
    if ( nil == sListener ) sListener = [[UIKeyboardListener alloc] init];    
    return sListener;
}

-(id) init {
    self = [super init];
    if ( self ) {
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(noticeShowKeyboard:) name:UIKeyboardDidShowNotification object:nil];
        [center addObserver:self selector:@selector(noticeHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) noticeShowKeyboard:(NSNotification *)inNotification {
    self.visible = true;
    self.keyboardFrame= [[[inNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
}

-(void) noticeHideKeyboard:(NSNotification *)inNotification {
    self.visible = false;
}

@end
