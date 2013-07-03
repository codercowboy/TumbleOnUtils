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
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com) for TumbleOn, March 2012.
 
 The latest version of this code is available here:
 
 - https://bitbucket.org/tumbleon/tumbleon-utils
 
 This code is licensed under the Apache license, a non-viral open source license
 that lets you use this code freely within your own projects without requiring
 your project itself to also be open source. More information about the Apache
 license is here:
 
 - http://en.wikipedia.org/wiki/Apache_license
 
 Copyright (c) 2012, Pocket Sized Giraffe, LLC. All rights reserved.
 
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