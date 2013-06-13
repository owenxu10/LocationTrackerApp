//
//  AlarmSettingViewController.h
//  LocationTracker
//
//  Created by Mengyi Zhou on 6/9/13.
//  Copyright (c) 2013 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaySettingViewController.h"
#import "sqlite3.h"
#import "Alarm.h"

@interface AlarmSettingViewController : UIViewController <AlarmSettingDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblText;
@property (weak, nonatomic) IBOutlet UIButton *btnRepeat;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;
@property (weak, nonatomic) IBOutlet UIDatePicker *alarmTime;
@property (weak, nonatomic) IBOutlet UISwitch *StopForLongTime;
@property (weak, nonatomic) IBOutlet UILabel *RepeatDay;
@property BOOL LongTime;
@property NSString *time;
@property NSString *busname;
@property NSNumber *Minutes;
@property NSString *repeat;


@end
