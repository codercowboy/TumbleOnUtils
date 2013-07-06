//
//  TumbleOnUtilsTests.m
//  TumbleOnUtilsTests
//
//  Created by Jason Baker on 7/2/13.
//  Copyright (c) 2013 Jason Baker. All rights reserved.
//

#import "TumbleOnUtilsTests.h"
#import "TumbleOnUtils.h"

@implementation TumbleOnUtilsTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in TumbleOnUtilsTests");
}

- (void) testToGrid {
    int colCount = 30;
    int rowCount = 30;
    for (int i = 0; i < 5; i++) {
        TOGrid * grid = [[TOGrid alloc] initWithColCount:colCount rowCount:rowCount];
        NSLog(@"Running test with array based grid..");
        [self runTestForGrid:grid];
    }    
}

- (void) runTestForGrid:(TOGrid*)grid {
    NSDate * startTime = [NSDate date];
    int colCount = grid.colCount;
    int rowCount = grid.rowCount;
    int runIterations = 1000000;
    for (int i = 0; i < runIterations; i++) {
        int col = arc4random() % colCount;
        int row = arc4random() % rowCount;
        [grid removeObjectAtCol:col row:row];
        NSObject * gridObject = [grid objectAtCol:col row:row];
        if (gridObject != nil) {
            STFail(@"Grid has object it shouldnt, just removed it..");
        }
        NSNumber * number = @(i);
        [grid setObject:number col:col row:row];
        gridObject = [grid objectAtCol:col row:row];
        if (number != gridObject) {
            STFail(@"Grid returned object that's not the one we added");
        }
    }
    NSTimeInterval timeElaped = [[NSDate date] timeIntervalSinceDate:startTime];
    float opsPerSec = runIterations / timeElaped;
    NSLog(@"TOGrid perf test completed in %fs, ops per sec: %f", timeElaped, opsPerSec);
}

@end
