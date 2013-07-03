//
//  ImageUtil.h
//  TumbleOn
//
//  Created by Jason Baker on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//TODO: collapse this into a UIIMage+TO

#import <Foundation/Foundation.h>

@interface ImageUtil : NSObject

+ (UIImage*)resizeImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize;
+ (CGSize) scalePhotoToFit:(CGSize)originalSize  maxSize:(CGSize)maxSize;

@end
