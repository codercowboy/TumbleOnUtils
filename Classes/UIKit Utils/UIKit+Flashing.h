//
//  UIKit+Flashing.h
//  RoofRats
//
//  Created by Jason Baker on 6/7/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFlashingLabel : UILabel
@property (nonatomic) NSTimeInterval flashDuration;
@property (nonatomic, strong) UIColor * flashColor;
@property (nonatomic) BOOL isFlashing;
//TODO: this class needs to have same style as flashing view below to prevent flicker craziness or doubling
@end

@interface UIFlashingView : UIView
@property (nonatomic) NSTimeInterval flashDuration;
@property (nonatomic, strong) UIColor * flashColor;
@property (nonatomic) CGFloat maxAlpha;
- (void) startAnimating;
- (void) stopAnimating;
@end
