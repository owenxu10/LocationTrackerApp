//
//  CoreLocationViewController.m
//  xo-corelocation
//
//  Created by haltink on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoreLocationViewController.h"

@implementation CoreLocationViewController
@synthesize locationManager; 
@synthesize locationLabelOne;
@synthesize locationLabelTwo;




#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setLocationManager:[[CLLocationManager alloc] init]];
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:kCLDistanceFilterNone]; 
    [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
    [self setLocationLabelOne:nil];
    [self setLocationLabelTwo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [locationLabelOne release];
    [locationLabelTwo release];
    [super dealloc];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    
    [locationLabelOne setText:[NSString stringWithFormat:@"%f", newLocation.coordinate.latitude]];
    
    [locationLabelTwo setText:[NSString stringWithFormat:@"%f", newLocation.coordinate.longitude]];
}

@end
