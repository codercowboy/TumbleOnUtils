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

#import <Foundation/Foundation.h>

@interface TOLLNode : NSObject
@property (strong) TOLLNode * next;
@property (strong) TOLLNode * prev;
@property (strong) NSObject * object;
+ (TOLLNode*) nodeWithObject:(NSObject*)object;
@end

@interface TOLinkedList : NSObject
@property (strong) TOLLNode * head;
@property (strong) TOLLNode * tail;
@property int count;

- (TOLLNode*)addObjectFront:(NSObject*)object;
- (TOLLNode*)addObjectBack:(NSObject*)object;
- (TOLLNode*)findNodeForObject:(NSObject*)object;
- (NSObject*)removeObject:(NSObject*)object;
- (NSObject*)removeHead;
- (NSObject*)removeTail;
- (NSObject*)removeNode:(TOLLNode*)node;
@end
