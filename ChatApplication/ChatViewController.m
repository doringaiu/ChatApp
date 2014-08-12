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

-(bool)checkForNewMessages;
- (IBAction)textFieldReturn:(id)sender;
- (IBAction)checkButtonPressed:(UIButton *)sender;
- (IBAction)sendMessageButton:(UIButton *)sender;
- (IBAction)swBack:(UISwipeGestureRecognizer *)sender;
- (IBAction)swToRecents:(UISwipeGestureRecognizer *)sender;



@end

@implementation ChatViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
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
        self.recievedMessages = [aDecoder decodeObjectForKey:@"recievedMessages"];
    }
    
    return self;
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
        
        //if(tempMSG.userID!=0)
        //{
            [self.listOfMessages addObject:tempMSG];
        [self.recievedMessages addObject:tempMSG];
        //}
        
        self.numberOfInsertedElements++;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"x";

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


- (void)dealloc {
    [_refreshTimer invalidate];
    _refreshTimer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
   // [[self.scrollViewChat subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)]; //  clear scroll view
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.pathMSG = [documentsDirectory stringByAppendingPathComponent:@"listOfMSG.plist"]; NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: self.pathMSG])
    {
        self.pathMSG = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat: @"listOfMSG.plist"] ];
    }
    
    [NSKeyedArchiver archiveRootObject:self.recievedMessages toFile:self.pathMSG];
    
}


-(IBAction)textFieldReturn:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)checkButtonPressed:(UIButton *)sender {
    if([self checkForNewMessages])
    {
        CGRect aRect;
        UILabel *recievedMessageLabel;
        UILabel *sentMessageLabel;
        
        self.didFinishFetching = false;

        for(int i=0;i<[self.listOfMessages count];i++)
        {
            NSString *currentUserName = [[self.listOfMessages objectAtIndex:i]userName];
            NSInteger swVar = 1;
            if([currentUserName isEqualToString:@"Dorin"])
            {
                swVar = 0;
            }
        
            NSString *nameAndText = [NSString stringWithFormat:@"%@  %@: \n %@",[[self.listOfMessages objectAtIndex:i]userName]
                                     ,[[self.listOfMessages objectAtIndex:i]date]
                                     ,[[self.listOfMessages objectAtIndex:i]messageText]];
            //switch([[[self.listOfMessages objectAtIndex:i]userName] isEqualToString:myUserID])
            switch(swVar)
            {
                case 0:
                    aRect = CGRectMake(120,self.messageHeight, 200, 100);
                    sentMessageLabel = [[UILabel alloc]initWithFrame:aRect];
                    

                    //sentMessageLabel.text = [[self.listOfMessages objectAtIndex:i]messageText];
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
                    break;
                default:
                {
                    //uint tempUserID = [[self.listOfMessages objectAtIndex:i]userName];
                    aRect = CGRectMake(0, 10+self.messageHeight, 200, 100);
                    recievedMessageLabel = [[UILabel alloc]initWithFrame:aRect];
                    
                    //
                   // NSString *nameAndText = [NSString stringWithFormat:@"%@: \n %@",[[self.listOfMessages objectAtIndex:i]userName]
                                            // ,[[self.listOfMessages objectAtIndex:i]messageText]];
                    //
            
                    //recievedMessageLabel.text = [[self.listOfMessages objectAtIndex:i]messageText];
                    recievedMessageLabel.text = nameAndText;
                    recievedMessageLabel.numberOfLines = 0; //will wrap text in new line
                    [recievedMessageLabel sizeToFit];
                    
                    [self.scrollViewChat addSubview:recievedMessageLabel];
                    recievedMessageLabel.backgroundColor = [UIColor colorWithRed:.55 green:.7 blue:.55 alpha:0.9];
                    recievedMessageLabel.textColor = [UIColor whiteColor];
                    recievedMessageLabel.layer.masksToBounds = YES;
                    self.messageHeight += recievedMessageLabel.frame.size.height+20;
                    recievedMessageLabel.layer.cornerRadius = 4;
                    self.scrollViewChat.contentSize = CGSizeMake(320, 10+self.messageHeight+100);
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



- (IBAction)sendMessageButton:(UIButton *)sender {
//    NewMessages *sendMessage = [[NewMessages alloc]init];
//    sendMessage.message = self.sendMessageTextField.text;
//    sendMessage.userID = 0; // my userID
//    [self.listOfMessages addObject:sendMessage];
//    [self.recievedMessages addObject:sendMessage];
    
    NSString *messageText = self.sendMessageTextField.text;
    if([messageText isEqualToString:@""] || messageText==nil) return;
    
    NSDate *currentDate = [NSDate date];
    ChatMessageModel *message = [[ChatMessageModel alloc] initWithMessageText:messageText :currentDate :myUserID];
    [self.messageSender sendMessage:message];
    
    self.sendMessageTextField.text = @"";
    //[self.listOfMessages addObject:message]; // array for display sent and recieved MSGs
    //[self.recievedMessages addObject:message];
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

- (IBAction)swBack:(UISwipeGestureRecognizer *)sender {
        [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)swToRecents:(UISwipeGestureRecognizer *)sender {
    [self.tabBarController setSelectedIndex:1];
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.recievedMessages forKey:@"recievedMessages"];
}

//-(id)initWithCoder:(NSCoder *) decoder
//{
//    self.recievedMessages = [decoder decodeObjectForKey:@"recievedMessages"];
//    return self;
//}
@end
