//
//  FirstItemViewController.m
//  ChatApplication
//
//  Created by iOSIntern8 on 7/24/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import "FirstItemViewController.h"
#import "SelectedContactViewController.h"
#include <Parse/Parse.h>

@interface FirstItemViewController () <initContactFieldsDelegate>
@property (weak, nonatomic) IBOutlet UITableView *contactsTableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *topBar;
@property int selectedRow;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
- (IBAction)addContactButton:(UIBarButtonItem *)sender;
- (void)editButtonPressed:(id)sender;
- (IBAction)swipeToRight:(UISwipeGestureRecognizer *)sender;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeToRightProperty;

@end

@implementation FirstItemViewController

-(void) saveEditedContact : (MyContact*)aContact
{
    [self.dataSource.listOfContacts replaceObjectAtIndex:self.selectedRow withObject:aContact];
    if(self.path)
    {
        [NSKeyedArchiver archiveRootObject:self.dataSource toFile:self.path];
    }
      [self.contactsTableView reloadData];
}

-(void) saveNewContact:(MyContact *)aContact
{
    [self.dataSource.listOfContacts addObject:aContact];

    if(self.path)
    {
        [NSKeyedArchiver archiveRootObject:self.dataSource toFile:self.path];
    }
        [self.contactsTableView reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.dataSource = [[MyContactsBook alloc] init];
    self.contactsTableView.delegate = self;
    self.contactsTableView.dataSource = self;

    self.topBar.topItem.title = @"My Contacts";
    
    self.editButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                   target:self
                                   action:@selector(editButtonPressed:)];
    self.topBar.topItem.rightBarButtonItem = self.editButton;
    
    // gesture
    
    [self.swipeToRightProperty setDirection:(UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionLeft )];
    [self.view addGestureRecognizer:self.swipeToRightProperty];
    
    // check if file Exists
//    static bool appLaunch = true;
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"listOfContactsFile" ofType:@"plist"];
//    //
//    [self.dataSource initWithSomeData];
//    [NSKeyedArchiver archiveRootObject:self.dataSource toFile:plistPath];
//    //
//    if(plistPath!=nil && appLaunch==true)
//    {
//        appLaunch = false;
//        self.dataSource = [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
//        [self.contactsTableView reloadData];
//        
//    }
    
    
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.path = [documentsDirectory stringByAppendingPathComponent:@"listOfContacts.plist"]; NSFileManager *fileManager = [NSFileManager defaultManager];
    
//    [self.dataSource initWithSomeData];
//    [NSKeyedArchiver archiveRootObject:self.dataSource toFile:self.path];
    
    if (![fileManager fileExistsAtPath: self.path])
    {
        self.path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat: @"listOfContacts.plist"] ];
    }
    
    static bool appStarted = true;
    if(appStarted)
    {
        self.dataSource = [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
        appStarted = false;
    }
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
}

- (IBAction)addContactButton:(UIBarButtonItem *)sender {
    UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SelectedContactViewController *selectedContactViewController = [myStoryBoard instantiateViewControllerWithIdentifier:@"selectedContactCntrlr"];
    selectedContactViewController.addNewContactWasPressed = true;
    selectedContactViewController.initContactsDelegate = self;
    [self.navigationController pushViewController:selectedContactViewController animated:YES];
    
}

- (void)editButtonPressed:(id)sender
{
    if ([self.contactsTableView isEditing]) {
        
        [self.contactsTableView setEditing:NO animated:YES];
        
    }
    else {
        
        // Turn on edit mode
        
        [self.contactsTableView setEditing:YES animated:YES];
    }
    
}

- (IBAction)swipeToRight:(UISwipeGestureRecognizer *)sender {
    [self.tabBarController setSelectedIndex:1];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"DefaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSString *myTemporaryString;
    myTemporaryString = [NSString stringWithFormat:@"%@ %@",
    [[self.dataSource contactAtIndex:indexPath.row]firstName],
    [[self.dataSource contactAtIndex:indexPath.row]lastName]];
    
    cell.imageView.image = [[self.dataSource contactAtIndex:indexPath.row]imageContact];

    cell.textLabel.text = myTemporaryString;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource sizeOfList];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SelectedContactViewController *selectedContactViewController = [myStoryBoard instantiateViewControllerWithIdentifier:@"selectedContactCntrlr"];
    self.selectedRow = indexPath.row;
    selectedContactViewController.contact = [self.dataSource.listOfContacts objectAtIndex:indexPath.row];
    selectedContactViewController.initContactsDelegate = self;
    [self.navigationController pushViewController:selectedContactViewController animated:YES];
    
    
}

- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.dataSource.listOfContacts removeObjectAtIndex:[indexPath row]];
        if(self.path)
        {
            [NSKeyedArchiver archiveRootObject:self.dataSource toFile:self.path];
        }
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
}

@end
