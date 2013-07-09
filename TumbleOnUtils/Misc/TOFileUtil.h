/*
 
 TOFileUtil
 
 A collection of file IO and filename related utilities.
 
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

@interface TOFileUtil : NSObject

// get the basename for a file from the given string, i.e. "FileUtil" from "FileUtil.h"
+ (NSString *) baseName:(NSString *)fileName;

// get the extension for a file from the given string, i.e. "h" from "FileUtil.h"
+ (NSString *) extension:(NSString*)fileName;

// load a file from disk, i.e.:
// NSString * html = [FileUtil loadFile:@"somefile.html"];
+ (NSString *) loadFile:(NSString *)fileName;

// deserialize a NSCoding compliant object (with initWithCoder:) from the given file path
+ (NSObject *) loadObjectFromDisk:(NSString *)fileName;

// serialize a NSCoding compliant object (with encodeWithCoder:) to a given file path
+ (void) saveObjectToFile:(NSString *)fileName object:(NSObject*)object;

+ (NSData *) loadDataFromDisk:(NSString *)fileName;
+ (void) saveDataToFile:(NSString *)fileName data:(NSData*)data;

@end
