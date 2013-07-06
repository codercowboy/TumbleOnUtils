/*
 
 TOWidgetExampleViewController
 
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

@interface TOWidgetExampleViewController : UIViewController
@property (nonatomic, strong) UIScrollView * scrollview;
@property (nonatomic) BOOL includeNameLabels;
@property (nonatomic, strong) UIView * lastAddedView;
- (void) addInstructions:(NSString*)instructions;
- (void) addWidgetView:(UIView*)widget;
- (void) addWidgetViewController:(UIViewController*)widget;
- (void) addWidgetWithName:(NSString*)name;
- (void) addView:(UIView*)view withClass:(Class)clz;
@end
