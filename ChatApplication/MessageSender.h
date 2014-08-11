//
//  MessageSender.h
//  ChatApplication
//
//  Created by iOSIntern8 on 8/7/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChatMessageModel;

@interface MessageSender : NSObject

-(void)sendMessage: (ChatMessageModel*)message;

@end
