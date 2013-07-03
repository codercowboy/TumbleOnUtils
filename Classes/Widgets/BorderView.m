//
//  BorderView.m
//  RoofRats
//
//  Created by Jason Baker on 5/4/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import "BorderView.h"

@implementation BorderView

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
