/*
 
 UIKit+TOFlashing
 
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