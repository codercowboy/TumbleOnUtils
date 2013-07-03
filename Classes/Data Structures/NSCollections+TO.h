//
//  NSArray+TO.h
//  TumbleOnUtils
//
//  Created by Jason Baker on 7/2/13.
//  Copyright (c) 2013 Jason Baker. All rights reserved.
//

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


