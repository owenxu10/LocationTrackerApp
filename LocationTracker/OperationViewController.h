//
//  OperationViewController.h
//  LocationTracker
//
//  Created by XUXU on 13-6-7.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import "MapViewController.h"
#import "AlarmSettingViewController.h"
#import "DurationTimeCalculator.h"


@interface OperationViewController : UIViewController <CLLocationManagerDelegate, NSURLConnectionDataDelegate>

@property (retain, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property NSNumber *ReceiveLatitude;
@property NSNumber *ReceiveLongitude;
@property NSNumber *currentLatitude;
@property NSNumber *currentLongitude;
@property NSString *timeLeft;

@end