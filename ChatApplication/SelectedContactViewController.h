//
//  SelectedContactViewController.h
//  ChatApplication
//
//  Created by iOSIntern8 on 7/24/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyContactsBook.h"

@protocol initContactFieldsDelegate <NSObject>

@optional
-(void) saveEditedContact : (MyContact*)aContact;
-(void) saveNewContact : (MyContact*)aContact;

@end

@interface SelectedContactViewController : UIViewController

@property (nonatomic,weak) id<initContactFieldsDelegate>initContactsDelegate;
@property MyContact *contact;
@property bool addNewContactWasPressed;
@end
