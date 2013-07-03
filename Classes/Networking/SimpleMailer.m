//
//  SimpleMailer.m
//  RoofRats
//
//  Created by Jason Baker on 6/1/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import "SimpleMailer.h"
#import "UIKit+TO.h"
#import <MessageUI/MessageUI.h>

@implementation SimpleMailerAttachment : NSObject
@end

@implementation SimpleMailer

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
    
    for (SimpleMailerAttachment * item in attachments) {
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
