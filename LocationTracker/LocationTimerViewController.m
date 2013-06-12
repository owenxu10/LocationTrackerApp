//
//  LocationTimerViewController.m
//  LocationTracker
//
//  Created by Mengyi Zhou on 6/6/13.
//  Copyright (c) 2013 Kettering. All rights reserved.
//

#import "LocationTimerViewController.h"
#import "Location.h"
#import "DurationTimeCalculator.h"

@interface LocationTimerViewController ()

@end

@implementation LocationTimerViewController
@synthesize btn_get = _btn_get;
@synthesize txt_show = _txt_show;

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

- (IBAction)btn_pressed:(id)sender {
    [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(handleTimer:) userInfo: nil repeats: YES];
}

-(void) handleTimer:(NSTimer *) timer{
    /*
    Location *origin = [[Location alloc]init];
    [origin setLatitude:43.01318000000001];
    [origin setLongitude:-83.71310000000001];
    
    Location *destination = [[Location alloc]init];
    [destination setLatitude:45.50987000000001];
    [destination setLongitude:-73.553770];
    
    DurationTimeCalculator *calculator = [[DurationTimeCalculator alloc] init];
    NSString *duration=[calculator getDurationfrom:origin to:destination];
    
    NSMutableString *result=[[NSMutableString alloc]init];
    [result appendString:self.txt_show.text];
    NSLog(@"%@", duration);
    [result appendString:duration];
    self.txt_show.text = result;
     
     
    
UILocalNotification* localNotification = [[UILocalNotification alloc] init];
localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:60];
localNotification.alertBody = @"Your alert message";
localNotification.timeZone = [NSTimeZone defaultTimeZone];
[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    */
    
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSDate *now=[NSDate new];
        notification.fireDate=[now dateByAddingTimeInterval:0];//10秒后通知
        notification.repeatInterval=0;//循环次数，kCFCalendarUnitWeekday一周一次
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber=1; //应用的红色数字
        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
        //去掉下面2行就不会弹出提示框
        notification.alertBody=@"通知内容";//提示信息 弹出提示框
        notification.alertAction = @"打开";  //提示框按钮
        //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失// NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
        //notification.userInfo = infoDict; //添加额外的信息
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }

}
@end
