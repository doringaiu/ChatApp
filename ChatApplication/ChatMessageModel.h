//
//  ChatMessageModel.h
//  ChatApplication
//
//  Created by iOSIntern8 on 8/7/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ChatMessageModel : NSObject <NSCoding>

@property (copy,nonatomic) NSString *messageText;
@property (strong,nonatomic) NSDate *date;
@property (strong,nonatomic)NSString *userName;

-(instancetype) initWithMessageText:(NSString*)messageText : (NSDate*) date : (NSString*) userName;
- (instancetype)initWithMessageObject:(PFObject *)parseObject;
- (PFObject *)parseObjectRepresentation;

@end
