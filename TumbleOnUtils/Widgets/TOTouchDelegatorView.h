/*
 
 TOTouchDelegatorView
 
 UIView that delegates all touch events (and long press gestures) to a delegate.
 
 USAGE INSTRUCTIONS
 
 We often use TouchDelegatorView in our apps to easily capture and forward a
 touch event (and/or long press gesture) simply. Example usages include overlaying
 our image stream images in TumbleOn with this view to grab the long press, or creating
 a full-screen transparent view below a popup view, to redirect touches to a close-popup
 event elsewhere.
 
 
 Simply create your TouchDelegatorView, and set its delegate to the class that should
 receive the touch events:
 
 - (void) viewDidLoad {
 [super viewDidLoad];
 TouchDelegatorView * delegator = [[TouchDelegatorView alloc] initWithFrame:CGRectMake(0,0,100,100)];
 delegator.delegate = self;
 [self.view addSubView:delegator];
 }
 
 - (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
 NSLog(@"Received touches ended event..");
 }
 
 - (void) longPress:(id)sender {
 NSLog(@"long press..");
 }
 
 
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

#import <UIKit/UIKit.h>

@interface TOTouchDelegatorView : UIView
@property (weak) UIResponder * delegate;
@end
