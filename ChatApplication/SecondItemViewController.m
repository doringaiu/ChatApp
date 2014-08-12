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

NSString *const messageFileName = @"listOfMSG.plist";

@interface SecondItemViewController () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeftToRightProperty;
@property (weak, nonatomic) IBOutlet UITableView *recentsTableView;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGestureProperty;

- (IBAction)swipeRightToLeft:(UISwipeGestureRecognizer *)sender;
- (IBAction)swipeLeftToRight:(UISwipeGestureRecognizer *)sender;
- (IBAction)pinchGestureRefresh:(UIPinchGestureRecognizer *)sender;

@end

@implementation SecondItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.swipeLeftToRightProperty setDirection:(UISwipeGestureRecognizerDirectionLeft| UISwipeGestureRecognizerDirectionLeft )];
    [self.view addGestureRecognizer:self.swipeLeftToRightProperty];
    [self.view addGestureRecognizer:self.pinchGestureProperty];
    self.recentMessages = [[NSMutableArray alloc]init];
}

#pragma mark - UITableViewMethods

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"DefaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [[self.recentMessages objectAtIndex:indexPath.row]userName];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recentMessages count];
}

#pragma mark - gestures

- (IBAction)pinchGestureRefresh:(UIPinchGestureRecognizer *)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:messageFileName];
    self.recentMessages = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    [self.recentsTableView reloadData];
}

- (IBAction)swipeRightToLeft:(UISwipeGestureRecognizer *)sender {
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)swipeLeftToRight:(UISwipeGestureRecognizer *)sender {
    [self.tabBarController setSelectedIndex:2];
}

@end
