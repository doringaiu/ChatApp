//
//  FirstItemViewController.h
//  ChatApplication
//
//  Created by iOSIntern8 on 7/24/14.
//  Copyright (c) 2014 Dorin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyContactsBook.h"

@interface FirstItemViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property MyContactsBook *dataSource;
@property NSString *path;
@end
