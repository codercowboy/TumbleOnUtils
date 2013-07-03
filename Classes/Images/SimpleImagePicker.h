//
//  SimpleImagePicker.h
//  RoofRats
//
//  Created by Jason Baker on 3/31/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleImagePicker : NSObject <UIImagePickerControllerDelegate, UIActionSheetDelegate>
@property (weak,nonatomic) UIViewController * parentViewController;
@property (strong,nonatomic) UIImage * selectedImage;
@property (nonatomic) BOOL saveImagesToCameraRoll;
- (void) showImagePickerOptions;
- (void) takeCameraPicture;
- (void) pickRollPicture;
@end
