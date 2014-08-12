//
//  MessageFetcher.h
//  ChatApplication
//
//  Created by iOSIntern8 on 8/7/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MessageFetcher;

@protocol MessageFetcherDelegate <NSObject>
- (void)messageFetcherDidFinishFetching:(MessageFetcher *)fetcher;
@end

@interface MessageFetcher : NSObject
@property (weak,nonatomic) id<MessageFetcherDelegate> delegate;
@property (copy,nonatomic) NSArray *allMesages;
-(void)fetchMessages;

@end
