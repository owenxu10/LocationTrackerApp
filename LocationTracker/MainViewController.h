//
//  MainViewController.h
//  LocationTracker
//
//  Created by XUXU on 13-5-15.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import "FlipsideViewController.h"
#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "Alarm.h"
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import "MapViewController.h"
#import "AlarmSettingViewController.h"
#import "DurationTimeCalculator.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,CLLocationManagerDelegate>

@property (retain, nonatomic) CLLocationManager *locationManager;

@end
