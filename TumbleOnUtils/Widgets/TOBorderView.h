/*
 
 TOBorderView
 
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
@interface TOBorderView : UIView
@property (nonatomic) CGFloat topWidth;
@property (nonatomic) CGFloat bottomWidth;
@property (nonatomic) CGFloat leftWidth;
@property (nonatomic) CGFloat rightWidth;
@property (nonatomic, strong) UIColor * topColor;
@property (nonatomic, strong) UIColor * bottomColor;
@property (nonatomic, strong) UIColor * leftColor;
@property (nonatomic, strong) UIColor * rightColor;
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UIView * bottomView;
@property (nonatomic, strong) UIView * leftView;
@property (nonatomic, strong) UIView * rightView;
- (void) setBorderColor:(UIColor *)borderColor;
- (void) setBorderWidth:(CGFloat)borderWidth;
@end
