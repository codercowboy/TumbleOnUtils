//
//  SimpleImagePicker.m
//  RoofRats
//
//  Created by Jason Baker on 3/31/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import "SimpleImagePicker.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface SimpleImagePicker ()
@property (nonatomic, strong) UIActionSheet * actionSheet;
@end

@implementation SimpleImagePicker

- (void) showImagePickerOptions {
    if(![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        [self pickRollPicture];
        return;
    }
    
    //camera is available, present user with choice..
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Camera Source"
                                        delegate:self
                               cancelButtonTitle:@"Cancel"
                          destructiveButtonTitle:nil
                               otherButtonTitles:@"Camera", @"Photo Albums", nil];
    
    [self.actionSheet showInView:self.parentViewController.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString * buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Camera"]) {
        [self takeCameraPicture];
    } else if ([buttonTitle isEqualToString:@"Photo Albums"]) {
        [self pickRollPicture];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if(self.saveImagesToCameraRoll && picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        // save to camera roll
        UIImageWriteToSavedPhotosAlbum(self.selectedImage, nil,nil, nil);
    }
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void) takeCameraPicture {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
    imagePicker.allowsEditing = NO;
    [self.parentViewController presentModalViewController:imagePicker animated:YES];
}

- (void) pickRollPicture {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self;
    imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
    imagePicker.allowsEditing = NO;
    [self.parentViewController presentModalViewController:imagePicker animated:YES];    
}

@end
