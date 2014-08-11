//
//  MyContact.h
//  MyApplication-3-Contacts
//
//  Created by iOSIntern8 on 7/18/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyContact : NSObject  <NSCoding>
@property NSString *firstName,*lastName;
@property int age,contactPhoneNumber;
@property UIImage *imageContact;
@end
