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
@synthesize LongTime;
@synthesize Minutes;
@synthesize time;

-(void) didDaySelection:(NSMutableArray *)selectedDay{
    NSString *objects = @"";
    NSString *temp= nil;
    int numberOfDay=0;
    for(id object in selectedDay){
       // NSLog(@"%@",(NSNumber *)object);
        if(([(NSNumber *)object intValue] ==0)&&(numberOfDay!=7))
        {
            temp=@"Sun";numberOfDay++;
            objects = [NSString stringWithFormat:@"%@ %@",objects,temp];
        }

        if(([(NSNumber *)object intValue] ==1)&&(numberOfDay!=7))
        {
            temp=@"Mon";numberOfDay++;
            objects = [NSString stringWithFormat:@"%@ %@",objects,temp];
        }
        
        if(([(NSNumber *)object intValue] ==2)&&(numberOfDay!=7))
        {
            temp=@"Tue";numberOfDay++;
            objects = [NSString stringWithFormat:@"%@ %@",objects,temp];
        }
        
        if(([(NSNumber *)object intValue] ==3)&&(numberOfDay!=7))
        {
            temp=@"Wed";numberOfDay++;
            objects = [NSString stringWithFormat:@"%@ %@",objects,temp];
        }
        
        if(([(NSNumber *)object intValue] ==4)&&(numberOfDay!=7))
        {
            temp=@"Thu";numberOfDay++;
            objects = [NSString stringWithFormat:@"%@ %@",objects,temp];
        }
        
        if(([(NSNumber *)object intValue] ==5)&&(numberOfDay!=7))
        {
            temp=@"Fri";numberOfDay++;
            objects = [NSString stringWithFormat:@"%@ %@",objects,temp];
        }
       
        if(([(NSNumber *)object intValue] ==6)&&(numberOfDay!=7))
        {
            temp=@"Sat";numberOfDay++;
            objects = [NSString stringWithFormat:@"%@ %@",objects,temp];
        }
        
        if(numberOfDay==7)
            objects = [NSString stringWithFormat:@"Every day"];
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
    self.lblText.text = time;
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"Alarm";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}

- (IBAction)savePressed:(id)sender {
    LongTime = StopForLongTime.isOn;
    int alarm = (int)floor(_alarmTime.countDownDuration);

    
    Minutes = [NSNumber numberWithInt:alarm];
    
    //NSString *strTest = [NSString stringWithFormat:@"%d", alarm];
    
}
@end
