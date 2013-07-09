/*
 
 TOGrid
 
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

#import "TOGrid.h"
#import "Foundation+TONilSafe.h"

@interface TOGrid()
@property NSMutableArray * grid;
@end

@implementation TOGrid
- (id) initWithColCount:(int)colCount rowCount:(int)rowCount {
    self = [super init];
    if (self) {
        self.colCount = colCount;
        self.rowCount = rowCount;
        int capacity = colCount * rowCount;
        self.grid = [NSMutableArray arrayWithCapacity:capacity];
        for (int i = 0; i < capacity; i++) {
            [self.grid addObject:[NSNull null]];
        }
    }
    return self;
}

- (int) indexForCol:(int)col row:(int)row {
    if (col >= self.colCount || row >= self.rowCount || col < 0 || row < 0) {
        return -1;
    }
    return (row * self.colCount) + col;
}

- (void) setObject:(NSObject *)object col:(int)col row:(int)row {
    int index = [self indexForCol:col row:row];
    if (index != -1) {
        self.grid[index] = (object == nil) ? [NSNull null] : object;
    }
}

- (NSObject *) objectAtCol:(int)col row:(int)row {
    int index = [self indexForCol:col row:row];
    if (index == -1) { return nil; }
    NSObject * o = self.grid[index];
    return (o == [NSNull null]) ? nil : o;
}

- (NSObject *) randomObject {
    int col = arc4random() % self.colCount;
    int row = arc4random() % self.rowCount;
    return [self objectAtCol:col row:row];
}

- (NSObject*) removeObjectAtCol:(int)col row:(int)row {
    int index = [self indexForCol:col row:row];
    if (index == -1) { return nil; }
    NSObject * o = self.grid[index];
    self.grid[index] = [NSNull null];
    return (o == [NSNull null]) ? nil : o;
}

- (NSArray*) allItems {
    NSMutableArray * array = [NSMutableArray array];
    for (NSObject * o in self.grid) {
        if (o != [NSNull null] && o != nil) {
            [array addObject:o];
        }
    }
    return array;
}

- (NSArray*) objectsAtCol:(int)col {
    NSMutableArray * array = [TONSMutableArrayNilSafe array];
    for (int row = 0; row < self.rowCount; row++) {
        NSObject * obj = [self objectAtCol:col row:row];
        if (obj != [NSNull null]) {
            [array addObject:obj];
        }
    }
    return array;
}

- (NSArray*) objectsAtRow:(int)row {
    NSMutableArray * array = [TONSMutableArrayNilSafe array];
    for (int col = 0; col < self.colCount; col++) {
        NSObject * obj = [self objectAtCol:col row:row];
        if (obj != [NSNull null]) {
            [array addObject:obj];
        }
    }
    return array;
}

- (void) removeAllObjects { [self.grid removeAllObjects]; }

- (BOOL) isEmptyAtCol:(int)col row:(int)row { return ([self objectAtCol:col row:row] == nil); }
- (BOOL) isColumnEmpty:(int)col { return [[self objectsAtCol:col] count] == 0; }
- (BOOL) isRowEmpty:(int)row { return [[self objectsAtRow:row] count] == 0; }

- (BOOL) isEmpty {
    for (int i = 0; i < self.colCount; i++) {
        if (![self isColumnEmpty:i]) {
            return NO;
        }
    }
    return YES;
}

- (int) findNextNonEmptyCol:(int)startCol {
    int col = startCol;
    while (col < self.colCount && [self isColumnEmpty:col]) {
        col++;
    }
    return (col == self.colCount) ? -1 : col;
}

- (int) findNextNonEmptyRow:(int)startRow {
    int row = startRow;
    while (row < self.rowCount && [self isRowEmpty:row]) {
        row++;
    }
    return (row == self.rowCount) ? -1 : row;
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
            [desc appendString:([self objectAtCol:c row:r] != nil ? @"X" : @" ")];
        }
        [desc appendString:@"\n"];
    }
    return desc;
}

@end
