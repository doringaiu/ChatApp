//
//  ChatViewController.h
//  ChatApplication
//
//  Created by iOSIntern8 on 7/25/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewMessages.h"

@protocol recentMessagesDelegate <NSObject>

@required

-(void)loadRecievedMessages : (NSMutableArray*)recievedMSG;

@end

@interface ChatViewController : UIViewController

@property (nonatomic,weak) id<recentMessagesDelegate>delegateMSG;
@property float messageHeight;
@property NSMutableArray *recievedMessages;
@property int cUserID; // set value when swiping from selectedContactVC

@end
