/*
 
 TOOperationManager
 
 A simple NSOperation manager, like NSOperationQueue, with some additional features.
 
 ABOUT
 
 OperationManager provides a simple interface to create a dynamic operation queue, with
 a configurable maximum number of threads and queue thread priority. 
 
 Threads are spun up as work is available, and die when all operations have been executed.
 
 A number of methods are provided to simplify working with NSOperations in your own project,
 with special emphesis placed on weak vs strong pointers to your target object.
 
 Supports queuing NSOperations you create yourself, or can create them for you.
 
 Supports block operations.
 
 USAGE INSTRUCTIONS
 
 See the OperationManagerExample.h and .m files for example usage.
 
 Simply allocate an instance of OperationManager, and hang on to it:
 
 self.opManager = [[OperationManager alloc] init];
 
 Then queue up operations like so:
 
 [self.opManager queueOperationWithWeakTarget:self 
    selector:@selector(performAction:) object:@"myOperation4"];
  
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

@interface TOOperationManager : NSObject
// initialize an OperationManager with (device core count * 2) max thread count, and
// DISPATCH_QUEUE_PRIORITY_BACKGROUND thread priority.
- (id) init;

// initialize an OperationManager with your own thread count and priority.
- (id) initWithMaxThreads:(int)threadCount queueThreadPriority:(int)queueThreadPriority;

// queue an operation you've created, this operation will be stored in a list
// while queued, with a strong pointer keeping the instance around.
- (void) queueOperation:(NSOperation*)operation;

// queue an operation block
- (NSOperation*) queueOperationBlock:(void (^)(void))block;

// queue an operation with a weak pointer to your target, allowing your target to
// dealloc safely before or while the operation executes
- (NSOperation*) queueOperationWithWeakTarget:(id)target selector:(SEL)sel object:(id)arg;

// queue an operation with a strong pointer to your target, forcing your target object
// to stick around until the operation is dequeued and finishes execution
- (NSOperation*) queueOperationWithStrongTarget:(id)target selector:(SEL)sel object:(id)arg;

// remove the given operation from our internal operation queue
- (void)removeOperation:(NSOperation*)op;

// current count of operations in queue
- (int) operationCount;

//convenience method to determine device's core count (i.e. single core vs dual core)
+ (int) deviceCoreCount;

@end
