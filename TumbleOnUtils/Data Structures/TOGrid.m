/*
 
 TOGridArray
 
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

@interface TOGrid ()
@property TONSMutableDictionaryNilSafe * grid;
@end

@implementation TOGrid
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
