//
//  MessageSender.m
//  ChatApplication
//
//  Created by iOSIntern8 on 8/7/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import "MessageSender.h"
#import "ChatMessageModel.h"
#import <Parse/Parse.h>


@implementation MessageSender

- (void)sendMessage:(ChatMessageModel*)message {
    // Create parse representation of message
    PFObject *messageObject = [message parseObjectRepresentation];
    
    // save it to Parse server
    [messageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
           // NSLog(@"Message %@ was saved successfuly", message.messageText);
        } else {
            //NSLog(@"Error while saving message. Error: %@", [error userInfo]);
        }
    }];
}

@end
