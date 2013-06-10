//
//  MapViewController.m
//  LocationTracker
//
//  Created by XUXU on 13-6-4.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import "MapViewController.h"
#import "AlarmViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController (){
    GMSMapView *mapView_;
}


@end

@implementation MapViewController
@synthesize Latitude;
@synthesize Longitude;
@synthesize busname;


/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (void)viewDidLoad
{
    
    //self.navigationItem.title = busname;
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:Latitude longitude:Longitude zoom:8];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
   // CLLocation *location = mapView_.myLocation;
    self.view = mapView_;
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(Latitude, Longitude);
    marker.title = busname;
    marker.snippet = @"how many mins";
    marker.map = mapView_;
    
    mapView_.settings.myLocationButton = YES;

    //[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.}
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
