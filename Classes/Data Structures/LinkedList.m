//
//  LinkedList.m
//  TumbleOn
//
//  Created by Jason Baker on 1/26/13.
//
//

#import "LinkedList.h"

@implementation LLNode
+ (LLNode*) nodeWithObject:(NSObject*)object {
    LLNode * node = [[LLNode alloc] init];
    node.object = object;
    return node;
}
@end

@implementation LinkedList

- (LLNode*)addObjectFront:(NSObject*)object {
    self.count++;
    LLNode * node = [LLNode nodeWithObject:object];
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

- (LLNode*)addObjectBack:(NSObject*)object {
    self.count++;
    LLNode * node = [LLNode nodeWithObject:object];
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

- (LLNode*)findNodeForObject:(NSObject*)object {
    LLNode * current = self.head;
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

- (NSObject*)removeNode:(LLNode*)node {
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
    LLNode * next = node.next;
    LLNode * prev = node.next;
    prev.next = next;
    next.prev = prev;
    node.next = nil;
    node.prev = nil;
    return node.object;
}


@end
