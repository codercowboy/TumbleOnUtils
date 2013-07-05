/*
 
 Foundation+TO
 
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
