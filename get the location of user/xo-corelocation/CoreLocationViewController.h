//
//  CoreLocationViewController.h
//  xo-corelocation
//
//  Created by haltink on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CoreLocationViewController : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (retain, nonatomic) IBOutlet UILabel *locationLabelOne;
@property (retain, nonatomic) IBOutlet UILabel *locationLabelTwo;

@end
