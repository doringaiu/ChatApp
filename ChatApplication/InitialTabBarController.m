//
//  InitialTabBarController.m
//  ChatApplication
//
//  Created by iOSIntern8 on 7/24/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import "InitialTabBarController.h"

@interface InitialTabBarController ()

@end

@implementation InitialTabBarController

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
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
//    [UITabBarItem.appearance setTitleTextAttributes:
//     @{NSForegroundColorAttributeName : [UIColor grayColor]}
//                                           forState:UIControlStateNormal];
//    [UITabBarItem.appearance setTitleTextAttributes:
//     @{NSForegroundColorAttributeName : [UIColor whiteColor]}
//                                           forState:UIControlStateSelected];
    
//    UITabBarItem *item0 = [self.tabBar.items objectAtIndex:0];
//    //unselected icon
//    item0.image = [[UIImage imageNamed:@"Happy_FaceV2 copy"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    //selected icon
//    item0.selectedImage = [UIImage imageNamed:@"Happy_Face"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end

/*
 [textFieldName resignFirstResponder]; - dissmis keyboard function
*/