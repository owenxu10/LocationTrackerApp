//
//  AlarmListViewController.h
//  LocationTracker
//
//  Created by Trees on 13-6-12.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "sqlite3.h"
#import "Alarm.h"

@interface AlarmListViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *TableView;

@end
