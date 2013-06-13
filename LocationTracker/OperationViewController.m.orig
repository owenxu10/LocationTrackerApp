//
//  OperationViewController.m
//  LocationTracker
//
//  Created by XUXU on 13-6-7.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import "OperationViewController.h"
#import "MapViewController.h"
#import "AlarmSettingViewController.h"
#import "Location.h"

@interface OperationViewController ()

@end

@implementation OperationViewController
@synthesize location;
@synthesize locationManager;
@synthesize info;
@synthesize ReceiveLongitude;
@synthesize ReceiveLatitude;
@synthesize currentLatitude;
@synthesize currentLongitude;
@synthesize time;
@synthesize timeLeft;

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
	// Do any additional setup after loading the view.
    info.text=[NSString stringWithFormat:@"%f, %f",
               ReceiveLatitude.doubleValue, ReceiveLongitude.doubleValue];
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"Operation";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    
    //get current location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *currentlocation = [locationManager location];
    // Configure the new event with information from the location
    CLLocationCoordinate2D coordinate = [currentlocation coordinate];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    currentLongitude = [NSNumber numberWithFloat:longitude.doubleValue];
    currentLatitude = [NSNumber numberWithFloat:latitude.doubleValue];
    
    location.text =[NSString stringWithFormat:@"%f, %f",
                    currentLatitude.doubleValue, currentLongitude.doubleValue];
    
    
    //get duration
    
    Location *origin = [[Location alloc]init];
    [origin setLatitude:currentLatitude.doubleValue];
    [origin setLongitude:currentLongitude.doubleValue];
    
    Location *destination = [[Location alloc]init];
    [destination setLatitude:ReceiveLatitude.doubleValue];
    [destination setLongitude:ReceiveLongitude.doubleValue];
<<<<<<< HEAD
    
    DurationTimeCalculator *calculator = [[DurationTimeCalculator alloc]init];
    
    NSString *startAddress = [calculator getStartAddressFrom:origin To:destination];
    NSString *endAddress = [calculator getEndAddressFrom:origin To:destination];
    info.text = startAddress;
    location.text = endAddress;
    
    NSString *duration=[calculator getDurationfrom:origin to:destination];
    int seconds = [duration intValue];
    NSString *formatDuration = [calculator getFormatTime:seconds];
    self.time.text= formatDuration;
=======
    NSString *duration=[self getDurationfrom:origin to:destination];
    int seconds = duration.intValue;
    int minutes = seconds/60;
    int hours = minutes/60;
    minutes = minutes - hours*60;
    seconds = seconds - minutes *60 - hours*3600;
    timeLeft =  [NSString stringWithFormat: @"About %d hours, %d mins and %d seconds.",hours,minutes,seconds];
    self.time.text=timeLeft ;
>>>>>>> b281de67f2da50837a9d1b0ff86f746138453b5a

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"ShowOnMap"]){
        MapViewController *map = [segue destinationViewController];
        map.busname = self.title;
        map.Latitude =  self.ReceiveLatitude.doubleValue;
        map.Longitude =self.ReceiveLongitude.doubleValue;
        
    }
    if([[segue identifier] isEqualToString:@"SetAlarm"]){
        AlarmSettingViewController *alarm = [segue destinationViewController];
        alarm.title = self.title;
        alarm.time = timeLeft;
    }

}



@end