/*
 
 FileUtil
 
 A collection of file IO and filename related utilities.
 
 ---
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com) for TumbleOn, March 2012.
 
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

#import "FileUtil.h"

@implementation FileUtil

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
    NSString * baseName = [FileUtil baseName:fileName];
    NSString * extension = [FileUtil extension:fileName];
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
    NSString *filePath = [FileUtil dataFilePath:fileName];
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
    [data writeToFile:[FileUtil dataFilePath:fileName] atomically:YES];
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
