//
//  AlarmSettingViewController.m
//  LocationTracker
//
//  Created by Mengyi Zhou on 6/9/13.
//  Copyright (c) 2013 Kettering. All rights reserved.
//

#import "AlarmSettingViewController.h"
#import "DaySettingViewController.h"

@interface AlarmSettingViewController ()

@end

@implementation AlarmSettingViewController
@synthesize alarmTime = _alarmTime;
@synthesize lblText = _lblText;
@synthesize RepeatDay;
@synthesize StopForLongTime;

-(void) didDaySelection:(NSMutableArray *)selectedDay{
    NSString *objects = @"";
    for(id object in selectedDay){
        
       objects = [NSString stringWithFormat:@"%@,%@",objects,object];
    }
    RepeatDay.text = objects;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //Get a handle on the view controller about be presented
    DaySettingViewController *controller = segue.destinationViewController;
    
    if ([controller isKindOfClass:[DaySettingViewController class]]) {
        controller.delegate = self;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)savePressed:(id)sender {
    BOOL LongTime = StopForLongTime.isOn;
    int alarm = (int)floor(_alarmTime.countDownDuration);
    NSString *strTest = [NSString stringWithFormat:@"%d", alarm];
    
    if(LongTime==YES ) _lblText.text = @"Yes";
    else _lblText.text = @"No";
        
   // _lblText.text = strTest;
}
@end
