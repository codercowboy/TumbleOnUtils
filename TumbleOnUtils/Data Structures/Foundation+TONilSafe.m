/*
 
 Foundation+TONilSafe
 
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

#import "Foundation+TONilSafe.h"

@implementation NSArray (TONilSafe)
+ (TONSMutableArrayNilSafe*) nilSafeMutableArray { return [TONSMutableArrayNilSafe array]; }
@end

@implementation NSDictionary (TONilSafe)
+ (TONSMutableDictionaryNilSafe*) nilSafeMutableDictionary { return [TONSMutableDictionaryNilSafe dictionary]; }
@end

@interface TONSMutableArrayNilSafe ()
@property (strong) NSMutableArray * backingStore;
@end

//backingStore example: http://stackoverflow.com/questions/5045071/subclassing-nsarray-nsmutablearray
@implementation TONSMutableArrayNilSafe

- (id)init {
    self = [super init];
    if (self) {
        self.backingStore = [NSMutableArray array];
    }
    return self;
}

+ (id)array { return [[TONSMutableArrayNilSafe alloc] init]; }

+ (id)arrayWithArray:(NSArray *)array {
    TONSMutableArrayNilSafe * result = [TONSMutableArrayNilSafe array];
    if (array != nil) { [result addObjectsFromArray:array]; }
    return result;
}

// all methods below this line required to impl by subclassing NSMutableArray

#pragma mark NSArray

-(NSUInteger)count { return [self.backingStore count]; }
-(id)objectAtIndex:(NSUInteger)index { return [self.backingStore objectAtIndex:index]; }

#pragma mark NSMutableArray

-(void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) return;
    [self.backingStore insertObject:anObject atIndex:index];
}

- (void)addObjectsFromArray:(NSArray *)otherArray {
    if (otherArray == nil || [otherArray count] == 0) { return; }
    [self.backingStore addObjectsFromArray:otherArray];
}

-(void)removeObjectAtIndex:(NSUInteger)index { [self.backingStore removeObjectAtIndex:index]; }

-(void)addObject:(id)anObject {
    if (anObject == nil) return;
    [self.backingStore addObject:anObject];
}

-(void)removeLastObject { [self.backingStore removeLastObject]; }

-(void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (anObject == nil) return;
    [self.backingStore replaceObjectAtIndex:index withObject:anObject];
}

@end

@interface TONSMutableDictionaryNilSafe ()
@property (strong) NSMutableDictionary * backingStore;
@end

@implementation TONSMutableDictionaryNilSafe

- (id)init {
    self = [super init];
    if (self) {
        self.backingStore = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (id)dictionary { return [[TONSMutableDictionaryNilSafe alloc] init]; }

- (void) setValue:(id)value forKey:(NSString *)key {
    if (value == nil || key == nil) { return; }
    [super setValue:value forKey:key];
}

// these are all required to use the backing store as a subclass of NSDictionary..

- (void) setObject:(id)anObject forKey:(id)aKey {
    if (anObject == nil || aKey == nil) {
        return;
    }
    [self.backingStore setObject:anObject forKey:aKey];
}

- (NSUInteger)count { return [self.backingStore count]; }
- (id)objectForKey:(id)aKey { return (aKey == nil) ? nil : [self.backingStore objectForKey:aKey]; }
- (NSEnumerator *)keyEnumerator { return [self.backingStore keyEnumerator]; }

- (void)removeObjectForKey:(id)aKey {
    if (aKey == nil) return;
    [self.backingStore removeObjectForKey:aKey];
}

@end