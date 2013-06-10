//
//  OperationViewController.m
//  LocationTracker
//
//  Created by XUXU on 13-6-7.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import "OperationViewController.h"
#import "MapViewController.h"

@interface OperationViewController ()

@end

@implementation OperationViewController
@synthesize info;
@synthesize ReceiveLongitude;
@synthesize ReceiveLatitude;

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
	// Do any additional setup after loading the view.
    [super viewDidLoad];
    info.text=[NSString stringWithFormat:@"%f, %f",
               ReceiveLatitude.doubleValue, ReceiveLongitude.doubleValue];
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"Operation";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
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
}
- (IBAction)ShowOnMap:(id)sender {
}
@end