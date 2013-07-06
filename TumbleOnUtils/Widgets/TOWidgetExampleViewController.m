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

#import "TOWidgetExampleViewController.h"
#import "UIView+TOFrameUtils.h"
#import "TOClassUtil.h"

@interface TOWidgetExampleViewController ()
@property (nonatomic) CGFloat maxY;
@end

@implementation TOWidgetExampleViewController

- (id)init {
    self = [super init];
    if (self) {
        self.maxY = 10;
        self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.scrollview.showsVerticalScrollIndicator = YES;
        self.includeNameLabels = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.scrollview.frame = self.view.frame;
    [self.scrollview frameMoveToX:0 y:0];
    [self.view addSubview:self.scrollview];
    [self.scrollview flashScrollIndicators];
}

- (void) addView:(UIView*)view withClass:(Class)clz {
    if (self.includeNameLabels) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10,self.maxY,300,20)];
        label.font = [UIFont boldSystemFontOfSize:16];
        label.text = [TOClassUtil prettyPrintClassName:clz];
        [self.scrollview addSubview:label];
        self.maxY += label.frame.size.height + 10;
    }
    [view frameMoveToY:self.maxY];
    [self.scrollview addSubview:view];
    [view frameCenterHorizontallyInParent];
    self.lastAddedView = view;
    self.maxY += view.frame.size.height + 10;
    self.scrollview.contentSize = CGSizeMake(320, self.maxY);
}

- (void) addInstructions:(NSString*)instructions {
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10,self.maxY,300,20)];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = instructions;
    [self.scrollview addSubview:label];
    self.maxY += label.frame.size.height + 10;
    self.scrollview.contentSize = CGSizeMake(320, self.maxY);
}

- (void) addWidgetView:(UIView*)widget {
    [self addView:widget withClass:[widget class]];
}

- (void) addWidgetViewController:(UIViewController*)widget {
    [self addChildViewController:widget];
    [self addView:widget.view withClass:[widget class]];
}

- (void) addWidgetWithName:(NSString*)name {
    NSObject * object = toInit(name);
    if ([object isKindOfClass:[UIViewController class]]) {
        [self addWidgetViewController:(UIViewController*)object];
    } else if ([object isKindOfClass:[UIView class]]) {
        [self addWidgetView:(UIView*)object];
    } else {
        NSLog(@"Could not determine view to add from widget w/ class name: %@", name);
    }
}

@end
