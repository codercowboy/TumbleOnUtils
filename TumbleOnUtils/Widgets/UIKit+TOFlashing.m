/*
 
 UIKit+TOFlashing
 
 ---
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com), Jun 2013.
 
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

#import "UIKit+TOFlashing.h"
#import "UIView+TOFrameUtils.h"
#import <QuartzCore/QuartzCore.h>

@interface TOUIFlashingLabel ()
@property UILabel * flashingLabel;
@end

@implementation TOUIFlashingLabel

- (void)setIsFlashing:(BOOL)isFlashing {
    BOOL wasFlashing = _isFlashing;
    _isFlashing = isFlashing;
    if (!isFlashing) {
        self.flashingLabel.hidden = YES;
        return;
    }
    if (self.flashingLabel == nil) {
        self.flashingLabel = [[UILabel alloc] initWithFrame:self.frame];
        [self.flashingLabel frameMoveToX:0 y:0];
        self.flashingLabel.font = self.font;
        self.flashingLabel.text = self.text;
        self.flashingLabel.backgroundColor = [UIColor clearColor];
        self.flashingLabel.textAlignment = self.textAlignment;
        self.flashingLabel.textColor = self.flashColor;
        [self addSubview:self.flashingLabel];
    }
    if (!wasFlashing) {
        self.flashingLabel.hidden = NO;
        self.flashingLabel.alpha = 0;
        [self flashAgain];
    }
}

- (void) flashAgain {
    if (!self.isFlashing) {
        return;
    }
    [UIView animateWithDuration:self.flashDuration animations:^{
        self.flashingLabel.alpha = (self.flashingLabel.alpha == 0) ? 1 : 0;
    } completion:^(BOOL finished) {
        [self flashAgain];
    }];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    self.flashingLabel.text = text;
}

- (void)setFlashColor:(UIColor *)flashColor {
    _flashColor = flashColor;
    self.flashingLabel.textColor = flashColor;
}

@end

@interface TOUIFlashingView ()
@property UIView * flashingView;
@property BOOL isFlashing;
@end

@implementation TOUIFlashingView

- (id)init {
    self = [super init];
    if (self) {
        self.maxAlpha = 1.0f;
    }
    return self;
}

- (void) startAnimating {
    if (self.isFlashing) {
        return;
    }
    self.isFlashing = YES;
    if (self.flashingView == nil) {
        self.flashingView = [[UIView alloc] initWithFrame:self.frame];
        [self.flashingView frameMoveToX:0 y:0];
        [self addSubview:self.flashingView];
    }
    self.flashingView.alpha = 0;
    [self flashAgain];
}

- (void) stopAnimating {
    if (!self.isFlashing) {
        return;
    }
    self.isFlashing = NO;
    [self.flashingView.layer removeAllAnimations];
    self.flashingView.alpha = 0;
}

- (void) flashAgain {
    if (!self.isFlashing) {
        return;
    }
    [self.flashingView.layer removeAllAnimations];
    [UIView animateWithDuration:self.flashDuration animations:^{
        self.flashingView.alpha = (self.flashingView.alpha == 0) ? self.maxAlpha : 0;
    } completion:^(BOOL finished) {
        [self flashAgain];
    }];
}

- (void)setFlashColor:(UIColor *)flashColor {
    _flashColor = flashColor;
    self.flashingView.backgroundColor = flashColor;
}

@end