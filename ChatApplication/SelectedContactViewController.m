//
//  SelectedContactViewController.m
//  ChatApplication
//
//  Created by iOSIntern8 on 7/24/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "SelectedContactViewController.h"
#import "FirstItemViewController.h"
#import "ChatViewController.h"

@interface SelectedContactViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageOfTheSelectedContact;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swChatProperty;
@property UIImagePickerController *imagePicker;
@property UIImage *imageFromGallery;
- (IBAction)saveChanges:(UIButton *)sender;
-(IBAction)textFieldReturn:(id)sender;
-(void)didTapImage;
- (IBAction)swBack:(UISwipeGestureRecognizer *)sender;
- (IBAction)swChat:(UISwipeGestureRecognizer *)sender;

@end

@implementation SelectedContactViewController

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
    self.firstNameTextField.text = self.contact.firstName;
    self.lastNameTextField.text = self.contact.lastName;
    self.ageTextField.text = [NSString stringWithFormat:@"%d",self.contact.age];
    self.phoneNumberTextField.text = [NSString stringWithFormat:@"%d",self.contact.contactPhoneNumber];
    if(!self.addNewContactWasPressed)
    {
        self.imageOfTheSelectedContact.image = self.contact.imageContact;
        self.imageOfTheSelectedContact.backgroundColor = [UIColor clearColor];
        self.imageOfTheSelectedContact.alpha = 1.0;
    }
    // add gesture recognizer
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(didTapImage)];
    tapRecognizer.numberOfTapsRequired = 1;
        // Add the tap gesture recognizer to the view

    [self.imageOfTheSelectedContact addGestureRecognizer:tapRecognizer];
    // Do any additional setup after loading the view, typically from a nib
    self.tabBarController.tabBar.hidden = YES;
    
    [self.swChatProperty setDirection:(UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionLeft )];
    [self.view addGestureRecognizer:self.swChatProperty];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
}

-(void)viewDidAppear:(BOOL)animated
{
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)didTapImage
{
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSURL *mediaURL;
    UIImage *image;
    mediaURL = (NSURL*)[info valueForKey:UIImagePickerControllerMediaURL];
    image = (UIImage*)[info valueForKey:UIImagePickerControllerOriginalImage];
    self.imageOfTheSelectedContact.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.imageFromGallery = image;
    self.imageOfTheSelectedContact.alpha = 1.0;
}

- (IBAction)swBack:(UISwipeGestureRecognizer *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.tabBarController setSelectedIndex:0];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveChanges:(UIButton *)sender {
    MyContact *tempContact = [[MyContact alloc]init];
    tempContact.firstName = self.firstNameTextField.text;
    tempContact.lastName = self.lastNameTextField.text;
    tempContact.age = [self.ageTextField.text intValue];
    tempContact.contactPhoneNumber = [self.phoneNumberTextField.text intValue];
    if(self.imageFromGallery)
    {
        tempContact.imageContact = self.imageFromGallery;
    }
    else
    {
        tempContact.imageContact = self.contact.imageContact;
    }
    
    if(self.addNewContactWasPressed)
    {
        [self.initContactsDelegate saveNewContact:tempContact];
    }
    
    else
    {
        [self.initContactsDelegate saveEditedContact:tempContact];
        
    }
    
    [self.view endEditing:YES];
    
}

-(IBAction)textFieldReturn:(id)sender
{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


- (IBAction)swChat:(UISwipeGestureRecognizer *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChatViewController *chatVC = [[ChatViewController alloc]init];
    chatVC = [storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
    //[cInfoViewController setTextFields:[self.dataSource.listOfContacts objectAtIndex:self.selectedRow]];
    //cInfoViewController.selectedContact = [self.dataSource.listOfContacts objectAtIndex:self.selectedRow];
    //cInfoViewController.editContactDelegateVar = self;
    [self.navigationController pushViewController:chatVC animated:YES];
    
}
@end
