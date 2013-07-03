/*
 
 TOOperationManagerExample
 
 Example code illustrating OperationManager API usage.
 
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

#import "TOOperationManagerExample.h"
#import "TOOperationManager.h"

@interface TOOperationManagerExample ()
@property (strong) TOOperationManager * opManager;
@property (strong) NSOperation * myOperation1;
@property (strong) NSOperation * myOperation2;
@end

@implementation TOOperationManagerExample
@synthesize opManager, myOperation1, myOperation2;

- (id)init {
    self = [super init];
    if (self) {
        //this will create an operation manager with a max thread count of (device core count * 2),
        // and a queue thread priority of DISPATCH_QUEUE_PRIORITY_BACKGROUND
        self.opManager = [[TOOperationManager alloc] init];
        
        //of course, we can dictate threadcount and queue thread priority too..
        self.opManager = [[TOOperationManager alloc] initWithMaxThreads:4 queueThreadPriority:DISPATCH_QUEUE_PRIORITY_LOW];
        
        //the operation manager is a simple beast, it spins up threads on-demand (when there's something to work on), and
        // kills them off when the queue is empty. the queue is fifo, a simple nsmutablearray.
        
        //in the case of executing a block operation, the block's strong or weak pointers to yourself
        // are up to you, we'd recommend a weak pointer like this unless you really want your object's
        // lifecycle to continue until the operation has executed..
        
        __weak TOOperationManagerExample * weakSelf = self;
        [self.opManager queueOperationBlock:^{
            [weakSelf performAction:@"block operation"];
        }];
        
        //we could also make our own block operation and pass it in this way..
        self.myOperation1 = [NSBlockOperation blockOperationWithBlock:^{
            [weakSelf performAction:@"myOperation1"];
        }];
        [self.opManager queueOperation:self.myOperation1];
        
        //in the case of a normal NSOperation, the target object is held with a strong pointer
        self.myOperation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(performAction:) object:@"myOperation2"];
        [self.opManager queueOperation:self.myOperation2];
        
        //operationManager has some other simplified methods to create an operation too..
        //in the strong case, a strong pointer to your target is held by the operation until it is dequeued and executed.
        NSOperation * myOperation3 = [self.opManager queueOperationWithStrongTarget:self selector:@selector(performAction:)
                                                                             object:@"myOperation3"];
        
        //in the weak case, a weak pointer to your target is held by the operation, and if your object deallocs before
        // operation execution, the operation becomes a no-op.
        
        [self.opManager queueOperationWithWeakTarget:self selector:@selector(performAction:) object:@"myOperation4"];
        
        //in both cases above, we don't have to save the operation if we don't want to, they're already strongly held by
        // the operationmanager's operation list.
        
        //if we really care for some reason, we can cancel an operation, of course, again effectively turning it into
        // a no-op when it's dequeued.. but remember that you can't gaurantee your cancel will happen before the operation's
        // already going..
        [myOperation3 cancel];
        
        //further, if for some reason you *really* want to ensure the operation's not in our operation list anymore, you can
        // do the following, but again, you can't gaurantee you're dequeuing something that's not already executing..
        [self.opManager removeOperation:myOperation3];        
    }
    return self;
}

- (void) performAction:(id)object {
    NSLog(@"Now executing operation: %@", (NSString *) object);
}

@end
