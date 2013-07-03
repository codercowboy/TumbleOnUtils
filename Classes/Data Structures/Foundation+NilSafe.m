/*
 
 Foundation+NilSafe
 
 ---
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com), 2012.
 
 The latest version of this code is available here:
 
 - https://bitbucket.org/tumbleon/tumbleon-utils
 
 This code is licensed under the Apache license, a non-viral open source license
 that lets you use this code freely within your own projects without requiring
 your project itself to also be open source. More information about the Apache
 license is here:
 
 - http://en.wikipedia.org/wiki/Apache_license
 
 Copyright (c) 2012, Pocket Sized Giraffe, LLC. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or other
 materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those of
 the authors and should not be interpreted as representing official policies, either
 expressed or implied.
 
 */

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