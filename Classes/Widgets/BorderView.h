//
//  BorderView.h
//  RoofRats
//
//  Created by Jason Baker on 5/4/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BorderView : UIView
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
