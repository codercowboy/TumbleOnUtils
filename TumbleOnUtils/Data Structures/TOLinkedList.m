/*
 
 TOLinkedList
 
 ---
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com), Jan 2013.
 
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
