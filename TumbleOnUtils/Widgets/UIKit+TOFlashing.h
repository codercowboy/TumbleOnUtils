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


#import <Foundation/Foundation.h>

@interface TOUIFlashingLabel : UILabel
@property (nonatomic) NSTimeInterval flashDuration;
@property (nonatomic, strong) UIColor * flashColor;
@property (nonatomic) BOOL isFlashing;
//TODO: this class needs to have same style as flashing view below to prevent flicker craziness or doubling
@end

@interface TOUIFlashingView : UIView
@property (nonatomic) NSTimeInterval flashDuration;
@property (nonatomic, strong) UIColor * flashColor;
@property (nonatomic) CGFloat maxAlpha;
- (void) startAnimating;
- (void) stopAnimating;
@end
