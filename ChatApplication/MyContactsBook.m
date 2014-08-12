//
//  MyContactsBook.m
//  MyApplication-3-Contacts
//
//  Created by iOSIntern8 on 7/18/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import "MyContactsBook.h"

NSString *const listKey = @"listOfContacts";

@implementation MyContactsBook

- (id)init {
    self = [super init];
    if (self) {
        _listOfContacts = [[NSMutableArray alloc]init];
    }
    return self;
    
    
}

-(void) addNewContact : (MyContact*)aNewContact
{
    [self.listOfContacts addObject:aNewContact];
}

-(void) EditContact : (int) contactId
{
    MyContact *editContact = [[MyContact alloc] init];

    [self.listOfContacts insertObject:editContact atIndex:contactId];
}

-(void) RemoveContact : (int)contactId
{
    [self.listOfContacts removeObjectAtIndex:contactId];
}

-(int) sizeOfList
{
    return [self.listOfContacts count];
}

-(MyContact*) contactAtIndex : (int) index
{
    return [self.listOfContacts objectAtIndex:index];
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.listOfContacts forKey:listKey];
}

-(id)initWithCoder:(NSCoder *) decoder
{
    self.listOfContacts = [decoder decodeObjectForKey:listKey];
    return self;
}

@end
