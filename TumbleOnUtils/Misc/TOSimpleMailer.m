/*
 
 TOSimpleMailer
 
 ---
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com), Jun 2013.
 
 The latest version of this code is available here:
 
 - https://bitbucket.org/tumbleon/tumbleon-utils
 
 This code is licensed under the Apache license, a non-viral open source license
 that lets you use this code freely within your own projects without requiring
 your project itself to also be open source. More information about the Apache
 license is here:
 
 - http://en.wikipedia.org/wiki/Apache_license
 
 Copyright (c) 2013, Pocket Sized Giraffe, LLC. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or other
 materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those of
 the authors and should not be interpreted as representing official policies, either
 expressed or implied.
 
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
