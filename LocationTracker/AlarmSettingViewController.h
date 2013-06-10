//
//  AlarmSettingViewController.h
//  LocationTracker
//
//  Created by Mengyi Zhou on 6/9/13.
//  Copyright (c) 2013 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaySettingViewController.h"
@interface AlarmSettingViewController : UITableViewController <AlarmSettingDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblText;

@end
