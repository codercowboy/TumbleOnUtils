//
//  ImageUtil.m
//  TumbleOn
//
//  Created by Jason Baker on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageUtil.h"

static inline double radians (double degrees) {return degrees * M_PI/180;}

@implementation ImageUtil

+ (UIImage*)resizeImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize {
    CGRect bounds = CGRectMake(0, 0, newSize.width, newSize.height);    
    UIGraphicsBeginImageContext(bounds.size);
    [sourceImage drawInRect:bounds];
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();    
    return imageCopy;
}

+ (CGSize) scalePhotoToFit:(CGSize)originalSize  maxSize:(CGSize)maxSize {
    CGFloat h = (CGFloat) originalSize.height;
    CGFloat w = (CGFloat) originalSize.width;

    CGFloat multiplier = maxSize.height / h;
    if (w > h) {
        multiplier = maxSize.width / w;
    }
    h = h * multiplier;
    w = w * multiplier;
    
    return CGSizeMake(w, h);    
}

@end
