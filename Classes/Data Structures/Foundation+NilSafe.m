//
//  Foundation+NilSafe.m
//  TumbleOnUtils
//
//  Created by Jason Baker on 7/3/13.
//  Copyright (c) 2013 Jason Baker. All rights reserved.
//

#import "Foundation+NilSafe.h"

@interface NSMutableArrayNilSafe ()
@property (strong) NSMutableArray * backingStore;
@end

@implementation NSMutableArrayNilSafe

- (id)init {
    self = [super init];
    if (self) {
        self.backingStore = [NSMutableArray array];
    }
    return self;
}

+ (id)array {
    return [[NSMutableArrayNilSafe alloc] init];
}

+ (id)arrayWithArray:(NSArray *)array {
    NSMutableArrayNilSafe * result = [NSMutableArrayNilSafe array];
    if (array != nil) {
        [result addObjectsFromArray:array];
    }
    return result;
}

// all methods below this line required to impl by subclassing NSMutableArray

#pragma mark NSArray

-(NSUInteger)count {
    return [self.backingStore count];
}

-(id)objectAtIndex:(NSUInteger)index {
    return [self.backingStore objectAtIndex:index];
}

#pragma mark NSMutableArray

-(void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) return;
    [self.backingStore insertObject:anObject atIndex:index];
}

- (void)addObjectsFromArray:(NSArray *)otherArray {
    if (otherArray == nil || [otherArray count] == 0) {
        return;
    }
    [self.backingStore addObjectsFromArray:otherArray];
}

-(void)removeObjectAtIndex:(NSUInteger)index {
    [self.backingStore removeObjectAtIndex:index];
}

-(void)addObject:(id)anObject {
    if (anObject == nil) return;
    [self.backingStore addObject:anObject];
}

-(void)removeLastObject {
    [self.backingStore removeLastObject];
}

-(void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (anObject == nil) return;
    [self.backingStore replaceObjectAtIndex:index withObject:anObject];
}


@end

@interface NSMutableDictionaryNilSafe ()
@property (strong) NSMutableDictionary * backingStore;
@end

@implementation NSMutableDictionaryNilSafe

- (id)init {
    self = [super init];
    if (self) {
        self.backingStore = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (id)dictionary {
    return [[NSMutableDictionaryNilSafe alloc] init];
}

- (void) setValue:(id)value forKey:(NSString *)key {
    if (value == nil || key == nil) {
        return;
    }
    [super setValue:value forKey:key];
}

// these are all required to use the backing store as a subclass of NSDictionary..

- (void) setObject:(id)anObject forKey:(id)aKey {
    if (anObject == nil || aKey == nil) {
        return;
    }
    [self.backingStore setObject:anObject forKey:aKey];
}

- (NSUInteger)count {
    return [self.backingStore count];
}

- (id)objectForKey:(id)aKey {
    if (aKey == nil) return nil;
    return [self.backingStore objectForKey:aKey];
}

- (NSEnumerator *)keyEnumerator {
    return [self.backingStore keyEnumerator];
}

- (void)removeObjectForKey:(id)aKey {
    if (aKey == nil) return;
    [self.backingStore removeObjectForKey:aKey];
}

@end

@interface NSMutableStringNilSafe ()
@property (strong,nonatomic) NSMutableString * innerString;
@end

@implementation NSMutableStringNilSafe

- (id)init {
    self = [super init];
    if (self) {
        self.innerString = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)appendString:(NSString *)aString {
    if (aString != nil) {
        [self.innerString appendString:aString];
    }
}

- (unichar)characterAtIndex:(NSUInteger)index {
    return [self.innerString characterAtIndex:index];
}

- (NSUInteger)length {
    return [self.innerString length];
}

@end