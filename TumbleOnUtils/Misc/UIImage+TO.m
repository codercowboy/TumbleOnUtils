/*
 
 UIImage+TO
 
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

#import "UIImage+TO.h"

@implementation UIImage (TO)
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
    
    return CGSizeMake(w * multiplier, h * multiplier);
}
@end
