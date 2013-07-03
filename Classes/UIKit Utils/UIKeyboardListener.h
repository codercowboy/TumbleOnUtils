//
//  UIKeyboardListener.h
//  TumbleOn
//
//  Created by Adam Zacharski on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIKeyboardListener : NSObject
@property BOOL visible;
@property CGRect keyboardFrame;
+ (UIKeyboardListener *) sharedInstance;
@end
