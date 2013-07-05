/*
 
 Foundation+TO
 
 ---
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com), 2012.
 
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

#import "Foundation+TO.h"

@implementation NSString (TO)
- (BOOL) contains:(NSString*)string {
    return [self rangeOfString:string].location != NSNotFound;
}

//from: http://cybersam.com/ios-dev/proper-url-percent-encoding-in-ios
//also: http://stackoverflow.com/questions/10548375/call-to-function-cfurlcreatestringbyaddingpercentescapes-returns-a-core-founda

// Encode a string to embed in an URL.
- (NSString*) urlEncode {
    NSString * encoded = (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef) self, NULL,
                                                                                                (CFStringRef) @"!*'();:@&=+$,/?%#[]",
                                                                                                kCFStringEncodingUTF8);
    return encoded;
}

// Decode a percent escape encoded string.
- (NSString*) urlDecode {
    NSString * decoded = (__bridge_transfer NSString *)
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef) self, CFSTR(""),
                                                            kCFStringEncodingUTF8);
    return decoded;
}
@end


@implementation NSNumber (TO)
- (NSString*) formatWithThousands {
    NSNumberFormatter * thousandsFormatter = [[NSNumberFormatter alloc] init];
    [thousandsFormatter setPositiveFormat:@"#,##0"];
    return [thousandsFormatter stringFromNumber:self];
}
@end


@implementation NSDate (TO)

- (NSString*) formatWithFormat:(NSString*)format {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

- (NSString*) formatDateddmmyyyy {
    return [self formatWithFormat:@"dd/MM/yyyy"];
}

- (NSString*) formatDatemmddyyyy {
    return [self formatWithFormat:@"MM/dd/yyyy"];
}

- (NSString*) formatDateyyyymmdd {
    return [self formatWithFormat:@"yyyy/MM/dd"];
}

- (NSString*) formatDateddmmyyyyWithSeperator:(NSString*)sep {
    return [self formatWithFormat:@"dd/MM/yyyy" seperator:sep];
}

- (NSString*) formatDatemmddyyyyWithSeperator:(NSString*)sep {
    return [self formatWithFormat:@"MM/dd/yyyy" seperator:sep];
}

- (NSString*) formatDateyyyymmddWithSeperator:(NSString*)sep {
    return [self formatWithFormat:@"yyyy/mm/dd" seperator:sep];
}

- (NSString*) formatTimehhmm {
    return [self formatWithFormat:@"hh:mm"];
}

- (NSString*) formatTimehhmmss {
    return [self formatWithFormat:@"hh:mm:ss"];
}

- (NSString*) formatTimehhmmWithSeperator:(NSString*)sep {
    return [self formatWithFormat:@"hh/mm" seperator:sep];
}

- (NSString*) formatTimehhmmssWithSeperator:(NSString*)sep {
    return [self formatWithFormat:@"hh/mm/ss" seperator:sep];
}


- (NSString*) formatWithFormat:(NSString *)format seperator:(NSString*)seperator {
    format = [format stringByReplacingOccurrencesOfString:@"/" withString:seperator];
    return [self formatWithFormat:format];
}

- (NSString*) formatISO8601 {
    return [self formatWithFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
}

static NSArray * _exampleDateFormatStrings;

+ (NSArray*) exampleDateFormatStrings {
    if (_exampleDateFormatStrings == nil) {
        _exampleDateFormatStrings = @[@"MM/dd/yyyy",@"dd/MM/yyyy",@"yyyy/MM/dd",@"MM/dd",
                                      @"MM/yyyy",@"yyyy/MM", @"MMM/yyyy", @"MMMM/yyyy",
                                      @"MM-dd-yyyy",@"dd-MM-yyyy",@"yyyy-MM-dd",@"MM-dd",
                                      @"MM-yyyy",@"yyyy-MM", @"MMM-yyyy", @"MMMM-yyyy",
                                      @"MM dd yyyy",@"dd MM yyyy",@"yyyy MM dd", @"MM dd",
                                      @"MM yyyy",@"yyyy MM", @"MMM yyyy", @"MMMM yyyy",
                                      @"MMM dd, yyyy",@"dd MMM, yyyy", @"MMM dd",
                                      @"MMMM dd, yyyy",@"dd MMMM, yyyy", @"MMMM dd"
                                      ];
    }
    return _exampleDateFormatStrings;
    
}

@end