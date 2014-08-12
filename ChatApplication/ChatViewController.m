//
//  ChatViewController.m
//  ChatApplication
//
//  Created by iOSIntern8 on 7/25/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import "ChatViewController.h"
#import "MessageSender.h"
#import "ChatMessageModel.h"
#import "MessageFetcher.h"
#import <Parse/Parse.h>

NSString *const myUserID = @"Dorin";
NSString *const emptyString = @"";
NSString *const messagesFileName = @"listOfMSG.plist";
NSString *const recievedMessagesKey = @"recievedMessages";

@interface ChatViewController () <MessageFetcherDelegate,NSCoding>

@property (weak, nonatomic) IBOutlet UITextField *sendMessageTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textBoxBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendMessageBottomConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewChat;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swToRecentsProperty;
@property (strong, nonatomic) MessageSender *messageSender;
@property (strong, nonatomic) MessageFetcher *fetcher;
@property NSMutableArray *listOfMessages;
@property BOOL didFinishFetching;
@property uint numberOfInsertedElements;
@property (strong, nonatomic) NSTimer *refreshTimer;

- (BOOL)checkForNewMessages;
- (IBAction)textFieldReturn:(id)sender;
- (IBAction)checkButtonPressed:(UIButton *)sender;
- (IBAction)sendMessageButton:(UIButton *)sender;
- (IBAction)swBack:(UISwipeGestureRecognizer *)sender;
- (IBAction)swToRecents:(UISwipeGestureRecognizer *)sender;

@end

@implementation ChatViewController

#pragma mark - NSCoding required methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // call checkButtonPressed in each 5 seconds
        _refreshTimer = [NSTimer scheduledTimerWithTimeInterval:5
                                                         target:self
                                                       selector:@selector(checkButtonPressed:)
                                                       userInfo:nil
                                                        repeats:YES];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillAppear)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillDisappear)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        self.recievedMessages = [aDecoder decodeObjectForKey:recievedMessagesKey];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.recievedMessages forKey:recievedMessagesKey];
}

#pragma mark - Custom Accessors

- (MessageSender *)messageSender {
    if (!_messageSender) {
        _messageSender = [[MessageSender alloc] init];
    }
    
    return _messageSender;
}

- (MessageFetcher *)fetcher {
    if (!_fetcher) {
        _fetcher = [[MessageFetcher alloc] init];
        _fetcher.delegate = self;
    }
    
    return _fetcher;
}

#pragma mark - MessageFetcherDelegate Methods

- (void)messageFetcherDidFinishFetching:(MessageFetcher *)fetcher {
    self.didFinishFetching = YES;
    // set msgs
    int numElements = [self.fetcher.allMesages count];
    
    NSMutableArray *newMSGs = [[NSMutableArray alloc] initWithArray:[self.fetcher allMesages]];
    
    for(int i = self.numberOfInsertedElements; i<numElements;i++)
    {
        ChatMessageModel *tempMSG = [[ChatMessageModel alloc]initWithMessageObject:newMSGs[i]];
        
        [self.listOfMessages addObject:tempMSG];
        [self.recievedMessages addObject:tempMSG];
        self.numberOfInsertedElements++;
    }
    
}

#pragma mark - Default View Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.listOfMessages = [[NSMutableArray alloc]init];
    self.recievedMessages = [[NSMutableArray alloc] init];
    
    [self.swToRecentsProperty setDirection:(UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionLeft )];
    [self.view addGestureRecognizer:self.swToRecentsProperty];
    
    static bool x = true;
    if(x)
    {
        self.messageHeight = 20;
        x = false;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.pathMSG = [documentsDirectory stringByAppendingPathComponent:messagesFileName]; NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: self.pathMSG])
    {
        self.pathMSG = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat: messagesFileName] ];
    }
    
    [NSKeyedArchiver archiveRootObject:self.recievedMessages toFile:self.pathMSG];
    
}

- (void)dealloc {
    [_refreshTimer invalidate];
    _refreshTimer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(IBAction)textFieldReturn:(id)sender
{
    [self.view endEditing:YES]; // dismiss keyboard
}

#pragma mark - Labels for Displaying Messages

- (void)createLabelForMyMessage:(NSString *)nameAndText {
    CGRect aRect;
    UILabel *sentMessageLabel;
    aRect = CGRectMake(120,self.messageHeight, 200, 100);
    sentMessageLabel = [[UILabel alloc]initWithFrame:aRect];
    
    sentMessageLabel.text = nameAndText;
    sentMessageLabel.numberOfLines = 0; //will wrap text in new line
    [sentMessageLabel sizeToFit];
    CGPoint newOrigin;
    newOrigin.y = sentMessageLabel.frame.origin.y;
    float actualWidth = sentMessageLabel.frame.size.width;
    if(actualWidth<239)
    {
        newOrigin.x = 320 - actualWidth;
        CGRect tempRectangle = CGRectMake(newOrigin.x, newOrigin.y, actualWidth, sentMessageLabel.frame.size.height);
        sentMessageLabel.frame = tempRectangle;
    }
    
    [self.scrollViewChat addSubview:sentMessageLabel];
    sentMessageLabel.textColor = [UIColor whiteColor];
    sentMessageLabel.backgroundColor = [UIColor grayColor];
    sentMessageLabel.layer.masksToBounds = YES;
    sentMessageLabel.layer.cornerRadius = 4;
    
    self.messageHeight += sentMessageLabel.frame.size.height+20;
    self.scrollViewChat.contentSize = CGSizeMake(320, 10+self.messageHeight+100);
}

- (void)CreateLabelForOtherUsersMessages:(NSString *)nameAndText {
    CGRect aRect;
    UILabel *recievedMessageLabel;
    aRect = CGRectMake(0, 10+self.messageHeight, 200, 100);
    recievedMessageLabel = [[UILabel alloc]initWithFrame:aRect];
    
    recievedMessageLabel.text = nameAndText;
    recievedMessageLabel.numberOfLines = 0;
    [recievedMessageLabel sizeToFit];
    
    [self.scrollViewChat addSubview:recievedMessageLabel];
    recievedMessageLabel.backgroundColor = [UIColor colorWithRed:.55 green:.7 blue:.55 alpha:0.9];
    recievedMessageLabel.textColor = [UIColor whiteColor];
    recievedMessageLabel.layer.masksToBounds = YES;
    self.messageHeight += recievedMessageLabel.frame.size.height+20;
    recievedMessageLabel.layer.cornerRadius = 4;
    self.scrollViewChat.contentSize = CGSizeMake(320, 10+self.messageHeight+100);
}

#pragma mark - Check for new messages functions

- (IBAction)checkButtonPressed:(UIButton *)sender {
    if([self checkForNewMessages])
    {
        self.didFinishFetching = false;
        
        for(int i=0;i<[self.listOfMessages count];i++)
        {
            NSString *currentUserName = [[self.listOfMessages objectAtIndex:i]userName];
            NSInteger swVar = 1;
            
            if([currentUserName isEqualToString:myUserID]){
                swVar = 0;
            }
            
            NSString *nameAndText = [NSString stringWithFormat:@"%@  %@: \n %@",[[self.listOfMessages objectAtIndex:i]userName]
                                     ,[[self.listOfMessages objectAtIndex:i]date]
                                     ,[[self.listOfMessages objectAtIndex:i]messageText]];
            switch(swVar)
            {
                case 0:
                    [self createLabelForMyMessage:nameAndText];
                    break;
                default:
                {
                    [self CreateLabelForOtherUsersMessages:nameAndText];
                    break;
                }
            }
        }
        [self.listOfMessages removeAllObjects];
    }
}

-(BOOL) checkForNewMessages
{
    [self.fetcher fetchMessages];
    return self.didFinishFetching;
}

#pragma mark - send Message methods

- (IBAction)sendMessageButton:(UIButton *)sender {
    NSString *messageText = self.sendMessageTextField.text;
    if([messageText isEqualToString:emptyString] || messageText==nil) return;
    
    NSDate *currentDate = [NSDate date];
    ChatMessageModel *message = [[ChatMessageModel alloc] initWithMessageText:messageText :currentDate :myUserID];
    [self.messageSender sendMessage:message];
    
    self.sendMessageTextField.text = emptyString;
    [self.view endEditing:YES];
}

-(void)keyboardWillAppear {
    self.textBoxBottomConstraint.constant = 227;
    self.sendMessageBottomConstraint.constant = 227;
    
}

-(void)keyboardWillDisappear {
    self.textBoxBottomConstraint.constant = 9;
    self.sendMessageBottomConstraint.constant = 9;
}

#pragma mark - Gesture functions

- (IBAction)swBack:(UISwipeGestureRecognizer *)sender {
        [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)swToRecents:(UISwipeGestureRecognizer *)sender {
    [self.tabBarController setSelectedIndex:1];
}

@end
