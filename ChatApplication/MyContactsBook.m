//
//  MyContactsBook.m
//  MyApplication-3-Contacts
//
//  Created by iOSIntern8 on 7/18/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import "MyContactsBook.h"

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

-(void) sortByName
{
    MyContact *tempContact = [[MyContact alloc]init];
    for(int i=0;i<[self sizeOfList];i++)
    {
        tempContact = [self.listOfContacts objectAtIndex:i];
        tempContact.firstName = [[self.listOfContacts objectAtIndex:i]firstName];
        tempContact.firstName = [tempContact.firstName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[tempContact.firstName substringToIndex:1] capitalizedString]];
        [self.listOfContacts replaceObjectAtIndex:i withObject:tempContact];
    }

    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"firstName" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [self.listOfContacts sortedArrayUsingDescriptors:sortDescriptors];
    self.listOfContacts = [sortedArray mutableCopy];
}

-(void) initWithSomeData
{
    MyContact *aContact = [[MyContact alloc] init];
    aContact.firstName = @"PList";
    aContact.lastName = @"Works";
    aContact.age = 23;
    aContact.contactPhoneNumber = 46464646;
    aContact.imageContact = nil;
    [self.listOfContacts addObject:aContact];
  
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.listOfContacts forKey:@"listOfContacts"];
}

-(id)initWithCoder:(NSCoder *) decoder
{
    self.listOfContacts = [decoder decodeObjectForKey:@"listOfContacts"];
    return self;
}

@end
