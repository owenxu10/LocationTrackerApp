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
{
    sqlite3 *alarmDB;
    NSString *dbPathString;
}
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
    
    [self getDataFromDB];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDataFromDB
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    
    dbPathString = [docPath stringByAppendingPathComponent:@"alarm.db"];
    
    char *error;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPathString]) {
        const char *dbPath = [dbPathString UTF8String];
        
        //creat db here
        if (sqlite3_open(dbPath, &alarmDB)==SQLITE_OK) {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS ALARMS (ID INTEGER PRIMARY KEY AUTOINCREMENT, BUSNAME TEXT, MINUTES INTEGER, REPEAT TEXT,StopForLongTime TEXT)";
            sqlite3_exec(alarmDB, sql_stmt, NULL, NULL, &error);
            sqlite3_close(alarmDB);
        }
    }
    sqlite3_stmt *statement;
    
    if (sqlite3_open([dbPathString UTF8String], &alarmDB)==SQLITE_OK) {
        
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM ALARMS"];
        const char* query_sql = [querySql UTF8String];
        
        if (sqlite3_prepare(alarmDB, query_sql, -1, &statement, NULL)==SQLITE_OK) {
            while (sqlite3_step(statement)==SQLITE_ROW) {
                NSString *busnamedb = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *minutes = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *repeat =[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *stopforlongtime =[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                
                NSLog(@"%@ %@ %@ %@",busnamedb,minutes,repeat,stopforlongtime);
            }
        }
    }
}


- (IBAction)btn_pressed:(id)sender {
    [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(scheduledSpy:) userInfo: nil repeats: YES];
    [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(longTimeSpy:) userInfo: nil repeats: YES];
    [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(todaySpy:) userInfo: nil repeats: YES];
}

-(void) scheduledSpy:(NSTimer *) timer{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    int week = [comps weekday];
    NSLog(@"%d",week);
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
        notification.fireDate=[now dateByAddingTimeInterval:0];
        notification.repeatInterval=0;//循环次数，kCFCalendarUnitWeekday一周一次
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber+=1; //应用的红色数字
        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
        //去掉下面2行就不会弹出提示框
        notification.alertBody=@"通知内容";
        notification.alertAction = @"打开";  
        //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失// NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
        //notification.userInfo = infoDict; //添加额外的信息
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

-(void) longTimeSpy:(NSTimer *) timer{
    
}

-(void) todaySpy:(NSTimer *) timer{
    
}
    
    
    

@end
