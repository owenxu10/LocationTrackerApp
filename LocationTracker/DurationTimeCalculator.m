//
//  DurationTimeCalculator.m
//  LocationTracker
//
//  Created by Mengyi Zhou on 6/4/13.
//  Copyright (c) 2013 Kettering. All rights reserved.
//

#import "DurationTimeCalculator.h"
#import "Location.h"
@interface DurationTimeCalculator ()

@end

@implementation DurationTimeCalculator
@synthesize txt_response = _txt_response;
@synthesize btn_get = _btn_get;

- (IBAction)btn_pressed:(id)sender{
    Location *origin = [[Location alloc]init];
    [origin setLatitude:0.000000];
    [origin setLongitude:0.000000];
    
    Location *destination = [[Location alloc]init];
    [destination setLatitude:4301349.000000];
    [destination setLongitude:-8371489.000000];
}

- (NSString *) getDurationfrom: (Location*) origin to:(Location*) destination{
    NSString *duration;
        NSString *from=[NSString stringWithFormat:@"%f,%f",[origin latitude],[origin longitude]];
    NSString *to=[NSString stringWithFormat:@"%f,%f",[destination latitude],[destination longitude]];    NSString *web_url = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=false&mode=driving", from, to];
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
