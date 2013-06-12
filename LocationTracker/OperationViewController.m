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
    NSString *duration=[self getDurationfrom:origin to:destination];
    int seconds = duration.intValue;
    int minutes = seconds/60;
    int hours = minutes/60;
    minutes = minutes - hours*60;
    seconds = seconds - minutes *60 - hours*3600;
    timeLeft =  [NSString stringWithFormat: @"About %d hours, %d mins and %d seconds.",hours,minutes,seconds];
    self.time.text=timeLeft ;

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





- (NSString *) getDurationfrom: (Location*) origin to:(Location*) destination{
    NSString *duration;
    NSString *from=[NSString stringWithFormat:@"%f,%f",[origin latitude],[origin longitude]];
    NSString *to=[NSString stringWithFormat:@"%f,%f",[destination latitude],[destination longitude]];
    
    NSString *web_url = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=false&mode=driving", from, to];
    //NSLog(@"%@", web_url);
    NSURL *final_Url = [NSURL URLWithString:web_url];
    NSData *data = [NSData dataWithContentsOfURL:final_Url];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSDictionary *routes = [json objectForKey:@"routes"];
    
    for(NSDictionary *route in routes){
        NSDictionary *legs = [route objectForKey:@"legs"];
        for(NSDictionary *leg in legs){
            NSArray *response_array = [[leg objectForKey:@"duration"] objectForKey:@"value"];
            duration =  [NSString stringWithFormat:@"%@", response_array];
        }
    }
    return duration;
    
}



@end