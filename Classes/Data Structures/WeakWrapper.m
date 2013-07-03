//
//  WeakWrapper.m
//  TumbleOn
//
//  Created by Jason Baker on 8/12/12.
//
//

#import "WeakWrapper.h"

@implementation WeakWrapper

+ (WeakWrapper *) wrapperForObject:(id)object {
    WeakWrapper * wrapper = [[WeakWrapper alloc] init];
    wrapper.wrappedObject = object;
    return wrapper;
}

@end
