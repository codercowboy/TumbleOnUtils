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

#import "TOOperationManager.h"
#import "TOWrappers.h"
#include <mach/mach_host.h> //for countCores method

@interface TOWeakNSInvocationOperation : NSObject
@property (weak) id target;
@property SEL   selector;
@property (strong) id obj;
- (void)start:(id)a;
@end

@implementation TOWeakNSInvocationOperation
@synthesize target, selector,obj;

- (void)start:(id)a {
    if([target respondsToSelector:selector]) {
        // hrm the warning for this is not good but as long as we don't call methods that return we should be ok
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:selector withObject:obj];
        #pragma clang diagnostic pop
    }
}

@end

@interface TOOperationManager ()
@property (strong) NSMutableArray * operationList;
@property int maxThreads;
@property int runningThreads;
@property dispatch_queue_t myQueue;
@end

@implementation TOOperationManager

@synthesize operationList, maxThreads, runningThreads, myQueue;

- (id) initWithMaxThreads:(int)threadCount queueThreadPriority:(int)queueThreadPriority {
    self = [super init];
    if (self) {
        self.maxThreads = threadCount;
        self.runningThreads = 0;
        self.operationList = [NSMutableArray array];
        self.myQueue = dispatch_get_global_queue(queueThreadPriority, 0);
    }
    return self;
}

- (id) init {
    self = [super init];
    if (self) {
        int threadCount = [TOOperationManager deviceCoreCount] * 2;
        int queueThreadPriority = DISPATCH_QUEUE_PRIORITY_BACKGROUND;
        self.maxThreads = threadCount;
        self.runningThreads = 0;
        self.operationList = [NSMutableArray array];
        self.myQueue = dispatch_get_global_queue(queueThreadPriority, 0);
    }
    return self;
}

//source for this method: http://stackoverflow.com/questions/7241936/how-do-i-detect-a-dual-core-cpu-on-ios
// thanks to the author: albertamg (http://stackoverflow.com/users/375300/albertamg)
+ (int) deviceCoreCount {
    host_basic_info_data_t hostInfo;
    mach_msg_type_number_t infoCount;    
    infoCount = HOST_BASIC_INFO_COUNT;
    host_info(mach_host_self(), HOST_BASIC_INFO, (host_info_t)&hostInfo, &infoCount);    
    return (int)(hostInfo.max_cpus);
}

-(NSOperation*) queueOperationWithWeakTarget:(id)i selector:(SEL)s object:(id)obj {
    TOWeakNSInvocationOperation * tar = [[TOWeakNSInvocationOperation alloc] init];
    tar.target=i;
    tar.selector=s;
    tar.obj = obj;
    NSInvocationOperation *op=[[NSInvocationOperation alloc] initWithTarget:tar selector:@selector(start:) object:nil];
    [self queueOperation:op];
    return op;
}

-(NSOperation*) queueOperationWithStrongTarget:(id)i selector:(SEL)s object:(id)obj {
    NSInvocationOperation *op=[[NSInvocationOperation alloc] initWithTarget:i selector:s object:obj];
    [self queueOperation:op];
    return op;
}


- (NSOperation*) queueOperationBlock:(void (^)(void))block {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:block];
    [self queueOperation:op];
    return op;
}

- (void) queueOperation:(NSOperation*)operation {
    @synchronized (self.operationList) {
        [self.operationList addObject:operation];
    }
    [self runLatest];
}

-(void) removeOperation:(NSOperation*)op {
    @synchronized (self.operationList) {
        [self.operationList removeObject:op];
    }
}

- (int) operationCount {
    @synchronized (self.operationList) {
        return [self.operationList count];
    }
}


- (void)runLatest {
    dispatch_async(myQueue, ^{
        // first check if there are already the max threads running:
        @synchronized (self.operationList) {
            if(self.runningThreads >= self.maxThreads)
                return;
            self.runningThreads++;
        }
        
        // otherwise start a run loop:
        while (YES) {
            NSOperation *opParams=nil;
            @synchronized (self.operationList) {
                int index = [self.operationList count] - 1;
                if(index < 0) {
                    self.runningThreads--;
                    return;
                }
                
                opParams = (NSOperation*)[self.operationList objectAtIndex:index];
                [self.operationList removeLastObject];
            }
            [opParams start];
        }
    });
}

@end
