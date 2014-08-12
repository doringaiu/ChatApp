//
//  MyContactsBook.h
//  MyApplication-3-Contacts
//
//  Created by iOSIntern8 on 7/18/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyContact.h"

@interface MyContactsBook : NSObject <NSCoding>
@property NSMutableArray *listOfContacts;
-(void) addNewContact : (MyContact*)aNewContact;
-(void) RemoveContact: (int) contactID;
-(int) sizeOfList;
-(MyContact*) contactAtIndex : (int) index;
@end
