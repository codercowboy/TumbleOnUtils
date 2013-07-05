/*
 
 TOBorderView
 
 ---
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com), May 2013.
 
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

#import "TOBorderView.h"

@implementation TOBorderView

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
    self.backgroundColor = [UIColor clearColor];
}

- (void) setBorderColor:(UIColor *)borderColor {
    self.leftColor = borderColor;
    self.rightColor = borderColor;
    self.topColor = borderColor;
    self.bottomColor = borderColor;
    [self setNeedsLayout];
}

- (void) setBorderWidth:(CGFloat)borderWidth {
    self.leftWidth = borderWidth;
    self.rightWidth = borderWidth;
    self.topWidth = borderWidth;
    self.bottomWidth = borderWidth;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    CGRect f = self.frame;
    if (self.leftWidth > 0) {
        if (self.leftView == nil) {
            self.leftView = [[UIView alloc] initWithFrame:CGRectZero];
            [self addSubview:self.leftView];
        }
        self.leftView.backgroundColor = self.leftColor;
        self.leftView.frame = CGRectMake(0,0,self.leftWidth, f.size.height);
    } else {
        [self.leftView removeFromSuperview];
        self.leftView = nil;
    }
    if (self.rightWidth > 0) {
        if (self.rightView == nil) {
            self.rightView = [[UIView alloc] initWithFrame:CGRectZero];
            [self addSubview:self.rightView];
        }
        self.rightView.backgroundColor = self.rightColor;
        self.rightView.frame = CGRectMake(f.size.width-self.rightWidth,0,self.rightWidth, f.size.height);
    } else {
        [self.rightView removeFromSuperview];
        self.rightView = nil;
    }
    if (self.topWidth > 0) {
        if (self.topView == nil) {
            self.topView = [[UIView alloc] initWithFrame:CGRectZero];
            [self addSubview:self.topView];
        }
        self.topView.backgroundColor = self.topColor;
        self.topView.frame = CGRectMake(0,0,f.size.width,self.topWidth);
    } else {
        [self.topView removeFromSuperview];
        self.topView = nil;
    }
    if (self.bottomView > 0) {
        if (self.bottomView == nil) {
            self.bottomView = [[UIView alloc] initWithFrame:CGRectZero];
            [self addSubview:self.bottomView];
        }
        self.bottomView.backgroundColor = self.bottomColor;
        self.bottomView.frame = CGRectMake(0,f.size.height - self.bottomWidth,f.size.width,self.bottomWidth);
    } else {
        [self.bottomView removeFromSuperview];
        self.bottomView = nil;
    }
}

- (void)setLeftColor:(UIColor *)leftColor {
    _leftColor = leftColor;
    [self setNeedsLayout];
}

- (void)setRightColor:(UIColor *)rightColor {
    _rightColor = rightColor;
    [self setNeedsLayout];
}

- (void)setTopColor:(UIColor *)topColor {
    _topColor = topColor;
    [self setNeedsLayout];
}

- (void)setBottomColor:(UIColor *)bottomColor {
    _bottomColor = bottomColor;
    [self setNeedsLayout];
}

- (void)setLeftWidth:(CGFloat)leftWidth {
    _leftWidth = leftWidth;
    [self setNeedsLayout];
}

- (void)setRightWidth:(CGFloat)rightWidth {
    _rightWidth = rightWidth;
    [self setNeedsLayout];
}

- (void)setTopWidth:(CGFloat)topWidth {
    _topWidth = topWidth;
    [self setNeedsLayout];
}

- (void) setBottomWidth:(CGFloat)bottomWidth {
    _bottomWidth = bottomWidth;
    [self setNeedsLayout];
}

@end
