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


#import <Foundation/Foundation.h>

@interface TOGrid : NSObject
@property int rowCount;
@property int colCount;

- (id) initWithColCount:(int)colCount rowCount:(int)rowCount;
- (void) setObject:(NSObject *)object  col:(int)col row:(int)row;

- (NSArray*) allItems;
- (NSObject *) objectAtCol:(int)col row:(int)row;
- (NSArray*) objectsAtCol:(int)col;
- (NSArray*) objectsAtRow:(int)row;
- (NSObject *) randomObject;

- (void) removeAllObjects;
- (BOOL) isEmpty;
- (BOOL) isEmptyAtCol:(int)col row:(int)row;
- (BOOL) isColumnEmpty:(int)col;
- (BOOL) isRowEmpty:(int)row;

- (NSObject*) removeObjectAtCol:(int)col row:(int)row;

- (int) findNextNonEmptyCol:(int)startCol;
- (int) findNextNonEmptyRow:(int)startRow;

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
