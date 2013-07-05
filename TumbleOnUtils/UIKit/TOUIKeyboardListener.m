/*
 
 TOUIKeyboardListener
 
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

#import "TOUIKeyboardListener.h"

@implementation TOUIKeyboardListener

+ (TOUIKeyboardListener *) sharedInstance {
    static TOUIKeyboardListener * sListener;    
    if ( nil == sListener ) sListener = [[TOUIKeyboardListener alloc] init];    
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
