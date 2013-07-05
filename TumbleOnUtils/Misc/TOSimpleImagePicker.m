/*
 
 TOSimpleImagePicker
 
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

#import "TOSimpleImagePicker.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface TOSimpleImagePicker ()
@property (nonatomic, strong) UIActionSheet * actionSheet;
@end

@implementation TOSimpleImagePicker

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
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void) takeCameraPicture {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
    imagePicker.allowsEditing = NO;
    [self.parentViewController presentViewController:imagePicker animated:YES completion:nil];
}

- (void) pickRollPicture {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self;
    imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
    imagePicker.allowsEditing = NO;
    [self.parentViewController presentViewController:imagePicker animated:YES completion:nil];
}

@end
