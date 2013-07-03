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

#import <Foundation/Foundation.h>

@interface TOGridArray : NSObject
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
