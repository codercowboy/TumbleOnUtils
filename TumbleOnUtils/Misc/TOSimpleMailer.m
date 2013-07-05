/*
 
 TOSimpleMailer
 
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

#import "TOSimpleMailer.h"
#import "UIKit+TO.h"
#import <MessageUI/MessageUI.h>

@implementation TOSimpleMailerAttachment
@end

@implementation TOSimpleMailer

- (void) sendEmailTo:(NSString*)to subject:(NSString*)subject message:(NSString*)message {
    [self sendEmailTo:to subject:subject message:message attachments:nil];
}

- (void) sendEmailTo:(NSString*)to subject:(NSString*)subject message:(NSString*)message attachments:(NSArray*)attachments {
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    if (subject != nil) {
        [picker setSubject:subject];
    }
    if (to != nil) {
        [picker setToRecipients:@[to]];
    }    
    if (message != nil) {
        [picker setMessageBody:message isHTML:NO];
    }
    
    for (TOSimpleMailerAttachment * item in attachments) {
        [picker addAttachmentData:item.data mimeType:item.mimeType fileName:item.fileName];
    }
    
    [self.parentVC presentViewController:picker animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    NSString * message = nil;
    if (error) {
        message = [NSString stringWithFormat:@"Email error: %@", [error localizedDescription]];
    }
    if (result == MFMailComposeResultFailed) {
        message = @"Email send failure";
    }
    if (result == MFMailComposeResultSent) {
        message = @"Email sent!";
    }
    if (message != nil) {
        [UIAlertView showSimpleAlert:message];
    }
    [self.parentVC dismissViewControllerAnimated:YES completion:nil];
}


@end
