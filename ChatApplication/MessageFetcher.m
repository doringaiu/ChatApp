//
//  MessageFetcher.m
//  ChatApplication
//
//  Created by iOSIntern8 on 8/7/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import "MessageFetcher.h"
#import <Parse/Parse.h>

@interface MessageFetcher ()

//@property (copy, nonatomic, readwrite) NSArray *allMSG;

@end

@implementation MessageFetcher

- (void)fetchMessages {
    PFQuery *query = [PFQuery queryWithClassName:@"message"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.allMesages = objects;
            [self.delegate messageFetcherDidFinishFetching:self];
            //NSLog(@"Received messages: %@", self.allMesages);
        }
    }];
    
}
@end
