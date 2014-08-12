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

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - gestures

- (IBAction)swMoveToLeft:(UISwipeGestureRecognizer *)sender {
    [self.tabBarController setSelectedIndex:1];
}
@end
