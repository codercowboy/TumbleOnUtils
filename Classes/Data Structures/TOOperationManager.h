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
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com) for TumbleOn, March 2012.
 
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
