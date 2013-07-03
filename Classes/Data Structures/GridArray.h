//
//  GridArray.h
//  QuickGame2
//
//  Created by Jason Baker on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridArray : NSObject
@property int rowCount;
@property int colCount;

- (id) initWithColCount:(int)colCount rowCount:(int)rowCount;
- (void) setObject:(NSObject *)object  col:(int)col row:(int)row;
- (NSObject *) objectAtCol:(int)col row:(int)row;
- (void) removeObjectAtCol:(int)col row:(int)row;
- (void) clear;
- (BOOL) isEmptyAtCol:(int)col row:(int)row;
- (NSArray*) allItems;
- (BOOL) isColumnEmpty:(int)col;
- (BOOL) isRowEmpty:(int)row;
- (int) findNexNonEmptyCol:(int)startCol;
- (int) findNexNonEmptyRow:(int)startRow;
- (NSArray*) objectsAtCol:(int)col;
- (NSArray*) objectsAtRow:(int)row;
- (NSObject *) randomObject;

- (NSObject*) getNeighborLeftAtCol:(int)col row:(int)row;
- (NSObject*) getNeighborRightAtCol:(int)col row:(int)row;
- (NSObject*) getNeighborTopAtCol:(int)col row:(int)row;
- (NSObject*) getNeighborBottomAtCol:(int)col row:(int)row;
- (NSObject*) getNeighborTopLeftAtCol:(int)col row:(int)row;
- (NSObject*) getNeighborTopRightAtCol:(int)col row:(int)row;
- (NSObject*) getNeighborBottomLeftAtCol:(int)col row:(int)row;
- (NSObject*) getNeighborBottomRightAtCol:(int)col row:(int)row;
- (NSArray*) getNeighborsLeftRightAtCol:(int)col row:(int)row;
- (NSArray*) getNeighborsTopBottomAtCol:(int)col row:(int)row;
- (NSArray*) getNeighborsLeftAtCol:(int)col row:(int)row;
- (NSArray*) getNeighborsRightAtCol:(int)col row:(int)row;
- (NSArray*) getNeighborsTopAtCol:(int)col row:(int)row;
- (NSArray*) getNeighborsBottomAtCol:(int)col row:(int)row;
- (NSArray*) getNeighborsAllSidesAtCol:(int)col row:(int)row;
- (NSArray*) getNeighborsAllCornersAtCol:(int)col row:(int)row;
- (NSArray*) getNeighborsAllAtCol:(int)col row:(int)row;

@end
