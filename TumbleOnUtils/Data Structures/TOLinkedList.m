/*
 
 TOLinkedList
 
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

#import "TOLinkedList.h"

@implementation TOLLNode
+ (TOLLNode*) nodeWithObject:(NSObject*)object {
    TOLLNode * node = [[TOLLNode alloc] init];
    node.object = object;
    return node;
}
@end

@implementation TOLinkedList

- (TOLLNode*)addObjectFront:(NSObject*)object {
    self.count++;
    TOLLNode * node = [TOLLNode nodeWithObject:object];
    if (self.head != nil) { //front already exists, fix pointers
        node.next = self.head;
        self.head.prev = node;
        self.head = node;        
    } else { //no front exists, which means no back exists, init..
        self.head = node;
        self.tail = node;
    }
    return node;
}

- (TOLLNode*)addObjectBack:(NSObject*)object {
    self.count++;
    TOLLNode * node = [TOLLNode nodeWithObject:object];
    if (self.head != nil) { //front already exists, fix pointers
        node.prev = self.tail;
        self.tail.next = node;
        self.tail = node;
    } else { //no front exists, which means no back exists, init..
        self.head = node;
        self.tail = node;
    }
    return node;
}

- (TOLLNode*)findNodeForObject:(NSObject*)object {
    TOLLNode * current = self.head;
    while (current != nil) {
        if (current.object == object) {
            return current;
        }
        current = current.next;
    }
    return nil;
}

- (NSObject*) removeObject:(NSObject*)object {
    return [self removeNode:[self findNodeForObject:object]];
}

- (NSObject*) removeHead {
    return [self removeNode:self.head];
}

- (NSObject*) removeTail {
    return [self removeNode:self.tail];
}

- (NSObject*)removeNode:(TOLLNode*)node {
    if (node == nil) {
        return nil;
    }
    self.count--;
    if (node == self.head && node == self.tail) { //only node we have, let it go..
        self.head = nil;
        self.tail = nil;
        return node.object;
    }
    if (node == self.head) {
        self.head = node.next;
        self.head.prev = nil;
        node.next = nil;
        return node.object;
    }
    if (node == self.tail) {
        self.tail = node.prev;
        self.tail.next = nil;
        node.prev = nil;
        return node.object;
    }
    //just some node in the middle of everything
    TOLLNode * next = node.next;
    TOLLNode * prev = node.next;
    prev.next = next;
    next.prev = prev;
    node.next = nil;
    node.prev = nil;
    return node.object;
}


@end
