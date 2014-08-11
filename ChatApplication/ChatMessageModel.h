//
//  ChatMessageModel.h
//  ChatApplication
//
//  Created by iOSIntern8 on 8/7/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ChatMessageModel : NSObject

@property (copy,nonatomic) NSString *messageText;
@property (strong,nonatomic) NSDate *date;
@property NSString *userName;

-(instancetype) initWithMessageText:(NSString*)messageText : (NSDate*) date : (int) userName;
- (instancetype)initWithMessageObject:(PFObject *)parseObject;
- (PFObject *)parseObjectRepresentation;

@end
