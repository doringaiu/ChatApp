//
//  MyContact.m
//  MyApplication-3-Contacts
//
//  Created by iOSIntern8 on 7/18/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import "MyContact.h"

NSString *const firstNameKey = @"firstName";
NSString *const lastNameKey = @"lastName";
NSString *const phoneKey = @"contactPhoneNumber";
NSString *const imageKey = @"imageContact";
NSString *const ageKey = @"age";

@implementation MyContact

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.firstName forKey:firstNameKey];
    [encoder encodeObject:self.lastName forKey:lastNameKey];
    [encoder encodeObject:[NSNumber numberWithInt:self.age] forKey:ageKey];
    [encoder encodeObject:[NSNumber numberWithInt:self.contactPhoneNumber] forKey:phoneKey];
    [encoder encodeObject:UIImagePNGRepresentation(self.imageContact) forKey:imageKey];
    
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self.firstName = [decoder decodeObjectForKey:firstNameKey];
    self.lastName = [decoder decodeObjectForKey:lastNameKey];
    self.age = (int) [[decoder decodeObjectForKey:ageKey]intValue];
    self.contactPhoneNumber = (int) [[decoder decodeObjectForKey:phoneKey]intValue];
    self.imageContact = [UIImage imageWithData:[decoder decodeObjectForKey:imageKey]];
    return self;
}

@end
