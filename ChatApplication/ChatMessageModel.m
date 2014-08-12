//
//  ChatMessageModel.m
//  ChatApplication
//
//  Created by iOSIntern8 on 8/7/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import "ChatMessageModel.h"

NSString *const ParseTextMessageKey = @"messageText";
NSString *const ParseTextDateKey = @"date";
NSString *const ParseUserID = @"userName";


@implementation ChatMessageModel

-(instancetype)initWithMessageText:(NSString *)messageText :(NSDate *)date :(NSString*)userName
{
    self = [super init];
    if(self)
    {
        _messageText = messageText;
        _date = date;
        _userName = userName;
    }
    
    return self;
}

-(instancetype) initWithMessageObject:(PFObject *)parseObject
{
    self = [super init];
    if(self)
    {
        _messageText = parseObject[ParseTextMessageKey];
        _date = parseObject[ParseTextDateKey];
        _userName = parseObject[ParseUserID];
    }
    
    return self;
}

- (PFObject *)parseObjectRepresentation
{
    PFObject *messageObject = [PFObject objectWithClassName:@"message"];
    [messageObject setObject:self.messageText forKey:ParseTextMessageKey];
    [messageObject setObject:self.date forKey:ParseTextDateKey];
    [messageObject setObject:self.userName forKey:ParseUserID];
    
    return messageObject;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.messageText forKey:@"messageText"];
    [encoder encodeObject:self.userName forKey:@"userName"];
    [encoder encodeObject:self.date forKey:@"date"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self.messageText = [decoder decodeObjectForKey:@"messageText"];
    self.userName = [decoder decodeObjectForKey:@"userName"];
    self.date = [decoder decodeObjectForKey:@"date"];
    return self;
}

@end
