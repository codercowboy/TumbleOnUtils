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

#import "TOTouchDelegatorView.h"

@implementation TOTouchDelegatorView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPressGesture.minimumPressDuration = 0.5f;
		[self addGestureRecognizer:longPressGesture];
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(touchesBegan:withEvent:)]) {
        [self.delegate touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(touchesCancelled:withEvent:)]) {
        [self.delegate touchesCancelled:touches withEvent:event];
    }
    [super touchesCancelled:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(touchesEnded:withEvent:)]) {
        [self.delegate touchesEnded:touches withEvent:event];
    }
    [super touchesEnded:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(touchesMoved:withEvent:)]) {
        [self.delegate touchesMoved:touches withEvent:event];
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture {
	// only when gesture was recognized, not when ended
	if (gesture.state == UIGestureRecognizerStateBegan) {
		if ([self.delegate respondsToSelector:@selector(longPress:)]) {
            [self.delegate performSelector:@selector(longPress:) withObject:nil];
        }
	}
}

@end