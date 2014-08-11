//
//  ThirdItemViewController.m
//  ChatApplication
//
//  Created by iOSIntern8 on 7/24/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import "ThirdItemViewController.h"

@interface ThirdItemViewController () <UIActionSheetDelegate>
- (IBAction)swMoveToLeft:(UISwipeGestureRecognizer *)sender;


@end

@implementation ThirdItemViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swMoveToLeft:(UISwipeGestureRecognizer *)sender {
    [self.tabBarController setSelectedIndex:1];
}
@end
