//
//  SecondItemViewController.m
//  ChatApplication
//
//  Created by iOSIntern8 on 7/24/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import "SecondItemViewController.h"
#import "ChatViewController.h"

@interface SecondItemViewController () <UITableViewDataSource,UITableViewDelegate,recentMessagesDelegate>
- (IBAction)swipeRightToLeft:(UISwipeGestureRecognizer *)sender;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeftToRightProperty;
- (IBAction)swipeLeftToRight:(UISwipeGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UITableView *recentsTableView;
@property NSMutableArray *recentMessages;

@end

@implementation SecondItemViewController

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
    [self.swipeLeftToRightProperty setDirection:(UISwipeGestureRecognizerDirectionLeft| UISwipeGestureRecognizerDirectionLeft )];
    [self.view addGestureRecognizer:self.swipeLeftToRightProperty];
    self.recentsTableView.delegate = self;
    self.recentsTableView.dataSource = self;
    //self.recentMessages = [[NSMutableArray alloc]init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)swipeRightToLeft:(UISwipeGestureRecognizer *)sender {
    [self.tabBarController setSelectedIndex:0];
}
- (IBAction)swipeLeftToRight:(UISwipeGestureRecognizer *)sender {
    [self.tabBarController setSelectedIndex:2];
}

-(void)loadRecievedMessages : (NSMutableArray*)recievedMSG
{
    self.recentMessages = [[NSMutableArray alloc]initWithArray:recievedMSG];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"DefaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    //cell.textLabel.text =
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recentMessages count];
}
@end
