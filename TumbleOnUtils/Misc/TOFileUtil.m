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

#import "TOFileUtil.h"

@implementation TOFileUtil

+ (NSString *) baseName:(NSString *)fileName {
    if (fileName == nil) {
        return nil;
    }
    NSRange range = [fileName rangeOfString:@"."];
    if (range.location == NSNotFound || (range.location + range.length) >= fileName.length) { 
        return nil;
    }
    return [fileName substringToIndex:range.location];    
}

+ (NSString *) extension:(NSString*)fileName {
    if (fileName == nil) {
        return nil;
    }
    NSRange range = [fileName rangeOfString:@"."];
    if (range.location == NSNotFound || (range.location + range.length) >= fileName.length) { 
        return nil;
    }    
    return [fileName substringFromIndex:range.location +1];    
}

+ (NSString *) loadFile:(NSString *)fileName {    
    NSString * baseName = [TOFileUtil baseName:fileName];
    NSString * extension = [TOFileUtil extension:fileName];
    NSString * filePath = [[NSBundle mainBundle] pathForResource:baseName ofType:extension];  
    if (!filePath) {
        NSLog(@"File Util Error, Couldn't find file: %@", fileName);
        return nil;
    }    
    NSString * fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];  
    if (!fileContents) {
        NSLog(@"File Util Error, Couldn't load file: %@", fileName);
        return nil;
    }    
    return fileContents;
}

+ (NSObject *) loadObjectFromDisk:(NSString *)fileName {
    NSObject * object = nil;
    NSString *filePath = [TOFileUtil dataFilePath:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        object = [unarchiver decodeObjectForKey:@"Data"];
        [unarchiver finishDecoding];
    }
    return object;
}

+ (void) saveObjectToFile:(NSString *)fileName object:(NSObject*)object {
    NSDate * startTime = [NSDate date];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:object forKey:@"Data"];
    [archiver finishEncoding];
    [data writeToFile:[TOFileUtil dataFilePath:fileName] atomically:YES];
    long timePassed_ms = (long) ([startTime timeIntervalSinceNow] * -1000.0);
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    int length = [data length];
    [params setValue:[NSNumber numberWithLong:timePassed_ms] forKey:@"time_elapsed"];
    [params setValue:[NSNumber numberWithLong:length] forKey:@"bytes"];
    [params setValue:fileName forKey:@"file"];
    NSLog(@"object saved to file: %@ in %ld ms, %d bytes", fileName, timePassed_ms, length);
}

+ (NSString *)dataFilePath:(NSString *)filename {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent: filename];
}

@end
