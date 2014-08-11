//
//  ChatViewController.h
//  ChatApplication
//
//  Created by iOSIntern8 on 7/25/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewMessages.h"



@interface ChatViewController : UIViewController

@property float messageHeight;
@property NSMutableArray *recievedMessages;
@property int cUserID; // set value when swiping from selectedContactVC

@end
