//
//  MyContact.m
//  MyApplication-3-Contacts
//
//  Created by iOSIntern8 on 7/18/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import "MyContact.h"

@implementation MyContact

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.firstName forKey:@"firstName"];
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:[NSNumber numberWithInt:self.age] forKey:@"age"];
    [encoder encodeObject:[NSNumber numberWithInt:self.contactPhoneNumber] forKey:@"contactPhoneNumber"];
    [encoder encodeObject:UIImagePNGRepresentation(self.imageContact) forKey:@"imageContact"];
    
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self.firstName = [decoder decodeObjectForKey:@"firstName"];
    self.lastName = [decoder decodeObjectForKey:@"lastName"];
    self.age = (int) [[decoder decodeObjectForKey:@"age"]intValue];
    self.contactPhoneNumber = (int) [[decoder decodeObjectForKey:@"contactPhoneNumber"]intValue];
    self.imageContact = [UIImage imageWithData:[decoder decodeObjectForKey:@"imageContact"]];
    return self;
}

@end
