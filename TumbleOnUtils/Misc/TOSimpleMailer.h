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

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

//mime type reference: https://en.wikipedia.org/wiki/Internet_media_type
@interface TOSimpleMailerAttachment : NSObject
@property (nonatomic, strong) NSData * data;
@property (nonatomic, strong) NSString * fileName;
@property (nonatomic, strong) NSString * mimeType;
@end

@interface TOSimpleMailer : NSObject <MFMailComposeViewControllerDelegate>
@property (nonatomic, weak) UIViewController * parentVC;
- (void) sendEmailTo:(NSString*)to subject:(NSString*)subject message:(NSString*)message;
- (void) sendEmailTo:(NSString*)to subject:(NSString*)subject message:(NSString*)message attachments:(NSArray*)attachments;
@end
