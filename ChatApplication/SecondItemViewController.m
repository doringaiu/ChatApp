//
//  SecondItemViewController.m
//  ChatApplication
//
//  Created by iOSIntern8 on 7/24/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import "SecondItemViewController.h"
#import "ChatViewController.h"
#import "ChatMessageModel.h"

@interface SecondItemViewController () <UITableViewDataSource,UITableViewDelegate>
- (IBAction)swipeRightToLeft:(UISwipeGestureRecognizer *)sender;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeftToRightProperty;
- (IBAction)swipeLeftToRight:(UISwipeGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UITableView *recentsTableView;
- (IBAction)pinchGestureRefresh:(UIPinchGestureRecognizer *)sender;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGestureProperty;

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
    [self.view addGestureRecognizer:self.pinchGestureProperty];
    
    //self.recentsTableView.delegate = self;
    //self.recentsTableView.dataSource = self;
    self.recentMessages = [[NSMutableArray alloc]init];
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

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"DefaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [[self.recentMessages objectAtIndex:indexPath.row]userName];
    
    NSLog(@"asdasd");
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recentMessages count];
}

- (IBAction)pinchGestureRefresh:(UIPinchGestureRecognizer *)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"listOfMSG.plist"];
    self.recentMessages = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    [self.recentsTableView reloadData];
}
@end
