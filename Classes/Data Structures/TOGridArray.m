/*
 
 TOGridArray
 
 ---
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com), Jan 2012.
 
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

#import "TOGridArray.h"
#import "Foundation+TONilSafe.h"

@interface TOGridArray ()
@property TONSMutableDictionaryNilSafe * grid;
@end

@implementation TOGridArray
- (id) initWithColCount:(int)colCount rowCount:(int)rowCount {
    self = [super init];
    if (self) {
        self.colCount = colCount;
        self.rowCount = rowCount;
        self.grid = [TONSMutableDictionaryNilSafe dictionary];
    }
    return self;
}

- (NSString*) indexForCol:(int)col row:(int)row {
    if (col >= self.colCount || row >= self.rowCount || col < 0 || row < 0) {
        return nil;
    }
    return [NSString stringWithFormat:@"%d,%d", col, row];
}

- (void) setObject:(NSObject *)object  col:(int)col row:(int)row {
    NSString * index = [self indexForCol:col row:row];
    if (index != nil) {
        [self.grid setObject:object forKey:index];
    }
}

- (NSObject *) objectAtCol:(int)col row:(int)row {
    NSString * index = [self indexForCol:col row:row];
    if (index == nil) {
        return nil;
    }
    return [self.grid objectForKey:index];
}

- (NSObject *) randomObject {
    NSArray * objects = [self.grid allValues];
    return [objects objectAtIndex:(arc4random() % objects.count)];
}

- (void) removeObjectAtCol:(int)col row:(int)row {
    NSString * index = [self indexForCol:col row:row];
    if (index != nil) {
        [self.grid removeObjectForKey:index];
    }
}

- (void) clear {
    [self.grid removeAllObjects];
}

- (BOOL) isEmptyAtCol:(int)col row:(int)row {
    return ([self objectAtCol:col row:row] == nil);
}

- (NSArray*) allItems {
    return [self.grid allValues];
}

- (NSArray*) objectsAtCol:(int)col {
    NSMutableArray * array = [TONSMutableArrayNilSafe array];
    for (int row = 0; row < self.rowCount; row++) {
        NSObject * obj = [self objectAtCol:col row:row];
        [array addObject:obj];
    }
    return array;
}

- (NSArray*) objectsAtRow:(int)row {
    NSMutableArray * array = [TONSMutableArrayNilSafe array];
    for (int col = 0; col < self.colCount; col++) {
        [array addObject:[self objectAtCol:col row:row]];
    }
    return array;
}

- (BOOL) isColumnEmpty:(int)col {
    return [[self objectsAtCol:col] count] == 0;
}

- (BOOL) isRowEmpty:(int)row {
    return [[self objectsAtRow:row] count] == 0;
}

- (int) findNexNonEmptyCol:(int)startCol {
    int col = startCol;
    while (col < self.colCount && [self isColumnEmpty:col]) {
        col++;
    }
    if (col == self.colCount) {
        return -1;
    }
    return col;
}

- (int) findNexNonEmptyRow:(int)startRow {
    int row = startRow;
    while (row < self.rowCount && [self isRowEmpty:row]) {
        row++;
    }
    if (row == self.rowCount) {
        return -1;
    }
    return row;
}

- (NSObject*) getNeighborLeftAtCol:(int)col row:(int)row {
    return [self objectAtCol:col-1 row:row];
}

- (NSObject*) getNeighborRightAtCol:(int)col row:(int)row {
    return [self objectAtCol:col+1 row:row];
}

- (NSObject*) getNeighborTopAtCol:(int)col row:(int)row {
    return [self objectAtCol:col row:row-1];
}

- (NSObject*) getNeighborBottomAtCol:(int)col row:(int)row {
    return [self objectAtCol:col row:row+1];
}

- (NSObject*) getNeighborTopLeftAtCol:(int)col row:(int)row {
    return [self objectAtCol:col-1 row:row-1];
}

- (NSObject*) getNeighborTopRightAtCol:(int)col row:(int)row {
    return [self objectAtCol:col+1 row:row-1];
}

- (NSObject*) getNeighborBottomLeftAtCol:(int)col row:(int)row {
    return [self objectAtCol:col-1 row:row+1];
}

- (NSObject*) getNeighborBottomRightAtCol:(int)col row:(int)row {
    return [self objectAtCol:col+1 row:row+1];
}

- (NSArray*) getNeighborsLeftRightAtCol:(int)col row:(int)row {
    NSMutableArray * neighbors = [TONSMutableArrayNilSafe array];
    [neighbors addObject:[self getNeighborLeftAtCol:col row:row]];
    [neighbors addObject:[self getNeighborRightAtCol:col row:row]];
    return neighbors;
}

- (NSArray*) getNeighborsTopBottomAtCol:(int)col row:(int)row {
    NSMutableArray * neighbors = [TONSMutableArrayNilSafe array];
    [neighbors addObject:[self getNeighborTopAtCol:col row:row]];
    [neighbors addObject:[self getNeighborBottomAtCol:col row:row]];
    return neighbors;
}

- (NSArray*) getNeighborsLeftAtCol:(int)col row:(int)row {
    NSMutableArray * neighbors = [TONSMutableArrayNilSafe array];
    [neighbors addObject:[self getNeighborTopLeftAtCol:col row:row]];
    [neighbors addObject:[self getNeighborLeftAtCol:col row:row]];
    [neighbors addObject:[self getNeighborBottomLeftAtCol:col row:row]];
    return neighbors;
}

- (NSArray*) getNeighborsRightAtCol:(int)col row:(int)row {
    NSMutableArray * neighbors = [TONSMutableArrayNilSafe array];
    [neighbors addObject:[self getNeighborTopRightAtCol:col row:row]];
    [neighbors addObject:[self getNeighborRightAtCol:col row:row]];
    [neighbors addObject:[self getNeighborBottomRightAtCol:col row:row]];
    return neighbors;
}

- (NSArray*) getNeighborsTopAtCol:(int)col row:(int)row {
    NSMutableArray * neighbors = [TONSMutableArrayNilSafe array];
    [neighbors addObject:[self getNeighborTopLeftAtCol:col row:row]];
    [neighbors addObject:[self getNeighborTopAtCol:col row:row]];
    [neighbors addObject:[self getNeighborTopRightAtCol:col row:row]];
    return neighbors;
}

- (NSArray*) getNeighborsBottomAtCol:(int)col row:(int)row {
    NSMutableArray * neighbors = [TONSMutableArrayNilSafe array];
    [neighbors addObject:[self getNeighborBottomLeftAtCol:col row:row]];
    [neighbors addObject:[self getNeighborBottomAtCol:col row:row]];
    [neighbors addObject:[self getNeighborBottomRightAtCol:col row:row]];
    return neighbors;
}

- (NSArray*) getNeighborsAllSidesAtCol:(int)col row:(int)row {
    NSMutableArray * neighbors = [TONSMutableArrayNilSafe array];
    [neighbors addObject:[self getNeighborLeftAtCol:col row:row]];
    [neighbors addObject:[self getNeighborTopAtCol:col row:row]];
    [neighbors addObject:[self getNeighborRightAtCol:col row:row]];
    [neighbors addObject:[self getNeighborBottomAtCol:col row:row]];
    return neighbors;
}

- (NSArray*) getNeighborsAllCornersAtCol:(int)col row:(int)row {
    NSMutableArray * neighbors = [TONSMutableArrayNilSafe array];
    [neighbors addObject:[self getNeighborTopLeftAtCol:col row:row]];
    [neighbors addObject:[self getNeighborTopRightAtCol:col row:row]];
    [neighbors addObject:[self getNeighborBottomLeftAtCol:col row:row]];
    [neighbors addObject:[self getNeighborBottomRightAtCol:col row:row]];
    return neighbors;
}

- (NSArray*) getNeighborsAllAtCol:(int)col row:(int)row {
    NSMutableArray * neighbors = [TONSMutableArrayNilSafe array];
    [neighbors addObject:[self getNeighborLeftAtCol:col row:row]];
    [neighbors addObject:[self getNeighborTopLeftAtCol:col row:row]];
    [neighbors addObject:[self getNeighborTopAtCol:col row:row]];
    [neighbors addObject:[self getNeighborTopRightAtCol:col row:row]];
    [neighbors addObject:[self getNeighborRightAtCol:col row:row]];
    [neighbors addObject:[self getNeighborBottomRightAtCol:col row:row]];
    [neighbors addObject:[self getNeighborBottomAtCol:col row:row]];
    [neighbors addObject:[self getNeighborBottomLeftAtCol:col row:row]];
    return neighbors;
}

- (NSString*) description {
    NSMutableString * desc = [[NSMutableString alloc] init];
    for (int r = 0; r < self.rowCount; r++) {
        for (int c = 0; c < self.colCount; c++) {
            if ([self objectAtCol:c row:r]) {
                [desc appendString:@"X"];
            } else {
                [desc appendString:@" "];
            }
        }
        [desc appendString:@"\n"];
    }
    return desc;
}

@end
