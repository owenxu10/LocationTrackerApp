//
//  LocationTimerViewController.h
//  LocationTracker
//
//  Created by Mengyi Zhou on 6/6/13.
//  Copyright (c) 2013 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "Alarm.h"
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import "MapViewController.h"
#import "AlarmSettingViewController.h"
#import "DurationTimeCalculator.h"


@interface LocationTimerViewController : UIViewController<CLLocationManagerDelegate>

@property (retain, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIButton *btn_get;
@property (weak, nonatomic) IBOutlet UITextView *txt_show;
- (IBAction)btn_pressed:(id)sender;

@end