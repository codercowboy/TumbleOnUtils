//
//  Foundation+NilSafe.h
//  TumbleOnUtils
//
//  Created by Jason Baker on 7/3/13.
//  Copyright (c) 2013 Jason Baker. All rights reserved.
//

#import <Foundation/Foundation.h>

//backingStore example: http://stackoverflow.com/questions/5045071/subclassing-nsarray-nsmutablearray
@interface NSMutableArrayNilSafe : NSMutableArray
@end

@interface NSMutableDictionaryNilSafe : NSMutableDictionary
@end

@interface NSMutableStringNilSafe : NSMutableString
@end
