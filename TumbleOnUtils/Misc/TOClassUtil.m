/*
 
 TOClassUtil
 
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

#import "TOClassUtil.h"
#import "Foundation+TO.h"

@implementation TOClassUtil
+ (NSString*) prettyPrintClassNameFromString:(NSString*)className {
    if (className == nil || className.length == 0) {
        return className;
    }
    className = [className removeSuffix:@"View"];
    className = [className removeSuffix:@"ViewController"];
    NSMutableString * output = [[NSMutableString alloc] init];
    int index = 0;
    while (index < className.length) {
        unichar c = [className characterAtIndex:index];
        BOOL isUpperCase = (c >= 'A' && c <= 'Z');
        [output appendFormat:(isUpperCase ? @" %c" : @"%c"), c];
        index++;
    }
    return output;
}

+ (NSString*) prettyPrintClassName:(Class)clz {
    return [TOClassUtil prettyPrintClassNameFromString:NSStringFromClass(clz)];
}

+ (id) initClassFromName:(NSString*)className {
    Class clz = NSClassFromString(className);
    return [[clz alloc] init];
}

@end
