/*
 
 NSCollections+TO
 
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

@interface NSArray (TO)
- (NSMutableArray *)reversedArray;
- (NSObject*) randomObject;
@end

@interface NSMutableArray (TO)
- (void)reverse;
- (NSObject*) removeRandomObject;
@end

@interface NSDictionary (TO)
- (NSObject*) keyForObject:(id)object;
@end


