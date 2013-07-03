//
//  LinkedList.h
//  TumbleOn
//
//  Created by Jason Baker on 1/26/13.
//
//

#import <Foundation/Foundation.h>

@interface LLNode : NSObject
@property (strong) LLNode * next;
@property (strong) LLNode * prev;
@property (strong) NSObject * object;
+ (LLNode*) nodeWithObject:(NSObject*)object;
@end

@interface LinkedList : NSObject
@property (strong) LLNode * head;
@property (strong) LLNode * tail;
@property int count;

- (LLNode*)addObjectFront:(NSObject*)object;
- (LLNode*)addObjectBack:(NSObject*)object;
- (LLNode*)findNodeForObject:(NSObject*)object;
- (NSObject*)removeObject:(NSObject*)object;
- (NSObject*)removeHead;
- (NSObject*)removeTail;
- (NSObject*)removeNode:(LLNode*)node;
@end
