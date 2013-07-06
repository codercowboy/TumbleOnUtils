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

- (NSString*) removePrefix:(NSString*)prefix {
    if (![self hasPrefix:prefix]) {
        return self;
    }
    if (self.length == prefix.length) {
        return @"";
    }
    return [self substringFromIndex:prefix.length];
}

- (NSString*) removeSuffix:(NSString*)suffix {
    if (![self hasSuffix:suffix]) {
        return self;
    }
    if (self.length == suffix.length) {
        return @"";
    }
    return [self substringToIndex:self.length - suffix.length];
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