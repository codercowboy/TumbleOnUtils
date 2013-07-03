//
//  NSArray+TO.m
//  TumbleOnUtils
//
//  Created by Jason Baker on 7/2/13.
//  Copyright (c) 2013 Jason Baker. All rights reserved.
//

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
    if (keys == nil) {
        return nil;
    }
    return [keys objectAtIndex:0];
}
@end

