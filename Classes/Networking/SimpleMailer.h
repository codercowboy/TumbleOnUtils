//
//  SimpleMailer.h
//  RoofRats
//
//  Created by Jason Baker on 6/1/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

//mime type reference: https://en.wikipedia.org/wiki/Internet_media_type
@interface SimpleMailerAttachment : NSObject
@property (nonatomic, strong) NSData * data;
@property (nonatomic, strong) NSString * fileName;
@property (nonatomic, strong) NSString * mimeType;
@end

@interface SimpleMailer : NSObject <MFMailComposeViewControllerDelegate>
@property (nonatomic, weak) UIViewController * parentVC;
- (void) sendEmailTo:(NSString*)to subject:(NSString*)subject message:(NSString*)message;
- (void) sendEmailTo:(NSString*)to subject:(NSString*)subject message:(NSString*)message attachments:(NSArray*)attachments;
@end
