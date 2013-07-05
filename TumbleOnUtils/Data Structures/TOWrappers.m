/*
 
 TOWrappers - a collection of simple primitive and weak wrappers
 
 Primitive Wrappers
 
 A collection of simple classes wrapping a mutable primitive value.
 
 Sometimes you want to store mutable numbers in a collection such as
 NSArray or NSDictionary, these classes make that possible.
 
 If you want to store immutable numbers in a collection, use NSNumber.
 
 Using one of the primitives is easy:
 
 IntWrapper * wrapper = [[IntWrapper alloc] init];
 wrapper.value = 25;
 
 NSMutableArray * array = [NSMutableArray array];
 [array addObject:wrapper;
 
 NSLog(@"value: %d", ((IntWrapper*)[array objectAtIndex:0]).value);
 
 ---
 
 Weak Wrapper
 
 A simple wrapper class with a weak pointer to the inner object.
 
 In IOS5 and below, collections such as NSArray and NSDictionary store
 objects with strong pointers, effectively attaching the lifecycle of your
 object to however long it is contained within the given collection.
 
 This class helps with that problem, simply do the following..
 
 self.myDictWithLotsOfThings = [NSMutableDictionary dictionary];
 
 WeakWrapper * wrapper = [WeakWrapper wrapperForObject:self.myDictWithLotsOfThings];
 
 [someArray addObject:wrapper];
 
 //the dictionary is immediately dealloced, despite being in the 'someArray' array.
 self.myDictWithLotsOfThings = nil;
 
 Note, there appear to be better options available in IOS6:
 
 [NSHashTable weakObjectsHashTable]
 [NSPointer weakObjectsPointerArray]
 [NSPointer pointerArrayWithOptions:]
 
 (source: http://stackoverflow.com/questions/9336288/nsarray-of-weak-references-to-objects-under-arc)
 
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

#import "TOWrappers.h"

@implementation TOIntWrapper
@end

@implementation TOLongWrapper
@end

@implementation TOFloatWrapper
@end

@implementation TOBoolWrapper
@end

@implementation TOWeakWrapper

+ (TOWeakWrapper *) wrapperForObject:(id)object {
    TOWeakWrapper * wrapper = [[TOWeakWrapper alloc] init];
    wrapper.wrappedObject = object;
    return wrapper;
}

@end
