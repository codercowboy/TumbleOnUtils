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


#import "NSCollections+TO.h"

@implementation NSArray (TO)

- (NSMutableArray *)reversedArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}

- (NSObject*) randomObject {
    if (self.count == 0) {
        return nil;
    }
    return [self objectAtIndex:(arc4random() % self.count)];
}

@end

@implementation NSMutableArray (TO)

- (void)reverse {
    NSUInteger i = 0;
    NSUInteger j = [self count] - 1;
    while (i < j) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:j];
        i++;
        j--;
    }
}

- (NSObject*) removeRandomObject {
    if (self.count == 0) {
        return nil;
    }
    int index = (arc4random() % self.count);
    NSObject * obj = [self objectAtIndex:index];
    [self removeObjectAtIndex:index];
    return obj;
}

@end

@implementation NSDictionary (CC)
- (NSObject*) keyForObject:(id)object {
    NSArray * keys = [self allKeysForObject:object];
    return (keys == nil) ? nil : [keys objectAtIndex:0];
}
@end

