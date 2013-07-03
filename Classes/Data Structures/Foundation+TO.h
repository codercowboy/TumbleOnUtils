//
//  Foundation+TO.h
//  TumbleOnUtils
//
//  Created by Jason Baker on 7/3/13.
//  Copyright (c) 2013 Jason Baker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TO)
- (BOOL) contains:(NSString*)string;
- (NSString*) urlEncode;
- (NSString*) urlDecode;
@end

@interface NSNumber (TO)
- (NSString*) formatWithThousands;
@end

@interface NSDate (TO)
- (NSString*) formatWithFormat:(NSString*)format;
- (NSString*) formatDateddmmyyyy;
- (NSString*) formatDatemmddyyyy;
- (NSString*) formatDateyyyymmdd;
- (NSString*) formatDateddmmyyyyWithSeperator:(NSString*)sep;
- (NSString*) formatDatemmddyyyyWithSeperator:(NSString*)sep;
- (NSString*) formatDateyyyymmddWithSeperator:(NSString*)sep;
- (NSString*) formatTimehhmm;
- (NSString*) formatTimehhmmss;
- (NSString*) formatTimehhmmWithSeperator:(NSString*)sep;
- (NSString*) formatTimehhmmssWithSeperator:(NSString*)sep;
- (NSString*) formatISO8601;
+ (NSArray*) exampleDateFormatStrings;
@end
