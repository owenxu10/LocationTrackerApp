//
//  MainViewController.m
//  LocationTracker
//
//  Created by XUXU on 13-5-15.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
{
    NSMutableData *webData;
    NSMutableArray *arrayOfSAlarm;
    NSMutableArray *arrayOfTAlarm;
    NSMutableArray *arrayOfLAlarm;
    sqlite3 *alarmDB;
    NSString *dbPathString;
    NSURLConnection *connection;
    NSMutableArray *arrayArduino;
    NSMutableArray *arrayLongitude;
    NSMutableArray *arrayLatitude;
    NSNumber *lat;
    NSNumber *lon;
    int tnum;
    int tnot;
    int tend;
    int lnot;
    int lend;
    int lnum;
    int sec;
    int send;
}

@end

@implementation MainViewController
@synthesize locationManager;


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = YES;
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"Location Tracker";
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"Back";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    tnum = lnum = 2;
    tnot = 1;
    tend = 1;
    lnot = 1;
    lend = 1;
    sec = 0;
    send =1;
    arrayArduino = [[NSMutableArray alloc]init];
    arrayLongitude= [[NSMutableArray alloc]init];
    arrayLatitude= [[NSMutableArray alloc]init];
    [self getDataFromDB];
    [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(scheduledSpy:) userInfo: nil repeats: YES];
    [NSTimer scheduledTimerWithTimeInterval: 5 target: self selector: @selector(longTimeSpy:) userInfo: nil repeats: YES];
    //[NSTimer scheduledTimerWithTimeInterval: 20  target: self selector: @selector(todaySpy:) userInfo: nil repeats: YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}



-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"fail with error");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    // NSDictionary *feed = [allDataDictionary objectForKey:@"feed"];
    //NSArray *arrayOfEntry = [feed objectForKey:@"entry"];
    
    for (NSDictionary *diction in allDataDictionary) {
        NSDictionary *arduino = [diction objectForKey:@"DeviceID"];
        NSDictionary *longitude = [diction objectForKey:@"Longitude"];
        NSDictionary *latitude = [diction objectForKey:@"Latitude"];
        [arrayArduino addObject:arduino];
        [arrayLongitude addObject:longitude];
        [arrayLatitude addObject:latitude];
    }
    
    
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
                
                NSLog(@"%@-%@-%@-%@",busnamedb,minutes,repeat,stopforlongtime);
                
                Alarm *Salarm = [[Alarm alloc]init];
                Alarm *Talarm = [[Alarm alloc]init];
                Alarm *Lalarm = [[Alarm alloc]init];
                [Lalarm setBusName:@"null"];
                [Lalarm setMinutes:0];
                [Lalarm setRepeat:@"null"];
                [Lalarm setLongTime: @"null"];
                
                [Talarm setBusName:@"null"];
                [Talarm setMinutes:0];
                [Talarm setRepeat:@"null"];
                [Talarm setLongTime: @"null"];
                
                [Salarm setBusName:@"null"];
                [Salarm setMinutes:0];
                [Salarm setRepeat:@"null"];
                [Salarm setLongTime: @"null"];
                if([stopforlongtime isEqualToString:@"YES"])
                {
                    [Lalarm setBusName:busnamedb];
                    [Lalarm setMinutes:[minutes intValue]];
                    [Lalarm setRepeat:repeat];
                    [Lalarm setLongTime: stopforlongtime];
                    
                    NSLog(@"Lalarm=%@",Lalarm.busName);
                    NSLog(@"Lalarm=%d",Lalarm.minutes);
                    NSLog(@"Lalarm=%@",Lalarm.LongTime);
                    NSLog(@"Lalarm=%@",Lalarm.Repeat);
                    
                }
                
                if(![repeat isEqualToString:@"(null)"])
                {
                    [Salarm setBusName:busnamedb];
                    [Salarm setMinutes:[minutes intValue]];
                    [Salarm setRepeat:repeat];
                    [Salarm setLongTime: stopforlongtime];
                    
                    //  NSLog(@"Salarm=%@",Lalarm.busName);
                    //   NSLog(@"Salarm=%d",Lalarm.minutes);
                    //   NSLog(@"Salarm=%@",Lalarm.LongTime);
                    //   NSLog(@"Salarm=%@",Lalarm.Repeat);
                    
                }
                else{
                    [Talarm setBusName:busnamedb];
                    [Talarm setMinutes:[minutes intValue]];
                    [Talarm setRepeat:repeat];
                    [Talarm setLongTime: stopforlongtime];
                    
                    //  NSLog(@"Talarm=%@",Talarm.busName);
                    //  NSLog(@"Talarm=%d",Talarm.minutes);
                    //  NSLog(@"Talarm=%@",Talarm.LongTime);
                    //  NSLog(@"Talarm=%@",Talarm.Repeat);
                }
                
                [arrayOfTAlarm addObject:Talarm];
                [arrayOfSAlarm addObject:Salarm];
                //if(![Lalarm.busName isEqualToString:@"(null)"])
                [arrayOfLAlarm addObject:Lalarm];
                
            }
        }
    }
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
    send--;
    NSLog(@"%d",send);
     if(send ==0 ){
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSDate *now=[NSDate new];
        notification.fireDate=[now dateByAddingTimeInterval:10];
        notification.repeatInterval=0;//循环次数，kCFCalendarUnitWeekday一周一次
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber+=1; //应用的红色数字
        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
        //去掉下面2行就不会弹出提示框
        notification.alertBody=@"Alarm";
        notification.alertAction = @"Open";
        //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失// NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
        //notification.userInfo = infoDict; //添加额外的信息
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        send=0;
    }
    }
}






-(void) todaySpy:(NSTimer *) timer{
    NSLog(@"today");
    if(tend !=0 ){
        Location *origin = [[Location alloc]init];
        
        Location *destination = [[Location alloc]init];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
        CLLocation *currentlocation = [locationManager location];
        // Configure the new event with information from the location
        CLLocationCoordinate2D coordinate = [currentlocation coordinate];
        
        [destination setLongitude: coordinate.longitude];
        [destination setLatitude:coordinate.latitude];
        
        
        NSURL *url = [NSURL URLWithString:@"http://asiangroup.mireene.com/locationTracker/index.php/get_newest_loc"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        connection = [NSURLConnection connectionWithRequest:request delegate:self];
        
        if(connection)
        {
            webData = [[NSMutableData alloc]init];
        }
        
        
        NSLog(@"===%d===",arrayArduino.count);
        for (int i = 0; i <  arrayOfTAlarm.count; i++)
        {
            NSLog(@"%i",tnum);
            if(tnum==0){
                NSString *bus=[[arrayOfTAlarm objectAtIndex:i] busName];
                int time = [[arrayOfLAlarm objectAtIndex:i] minutes];
                if(![bus isEqualToString:@"null"])
                {
                    NSLog(@"%@",bus);
                    NSLog(@"%d",time);
                    NSLog(@"the idx is:%i",[arrayArduino indexOfObject:bus]);
                    
                    int index = [arrayArduino indexOfObject: bus];
                    NSLog(@"%d",index);
                    NSNumber *numberLatitude  = [arrayLatitude objectAtIndex:index];
                    NSNumber *numberLongitude = [arrayLongitude objectAtIndex:index];
                    
                    [origin setLatitude:[numberLatitude floatValue]];
                    [origin setLongitude:[numberLongitude floatValue]];
                    
                    DurationTimeCalculator *calculator = [[DurationTimeCalculator alloc] init];
                    int duration=[[calculator getDurationfrom:origin to:destination] intValue];
                    
                    
                    if(duration == time )
                    {
                        if(tnot!=0){
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alarm on "
                                                                                message:[NSString stringWithFormat:@"%@ will come in %d mins",bus,time/60]
                                                                               delegate:self
                                                                      cancelButtonTitle:@"Cancel"
                                                                      otherButtonTitles:@"OK", nil];
                            [alertView show];
                            tend=0;
                            //UILocalNotification* localNotification = [[UILocalNotification alloc] init];
                            //localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:60];
                            //localNotification.alertBody = [NSString stringWithFormat:@"%@ is coming in %d mins",bus,time];
                            //localNotification.timeZone = [NSTimeZone defaultTimeZone];
                            //[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                            if(tnot !=0) tnot --;
                        }
                    }
                }
                
            }
            
        }
        if(tnum !=0)
            tnum --;
    }
    [arrayArduino removeAllObjects];
    [arrayLongitude removeAllObjects];
    [arrayLatitude removeAllObjects];
    
}

-(void) longTimeSpy:(NSTimer *) timer{
    NSLog(@"longtime");
    if(lend!=0 ){
        
        NSURL *url = [NSURL URLWithString:@"http://asiangroup.mireene.com/locationTracker/index.php/get_newest_loc"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        connection = [NSURLConnection connectionWithRequest:request delegate:self];
        
        if(connection)
        {
            webData = [[NSMutableData alloc]init];
        }
        
        
        NSLog(@"---------%d-------------",arrayArduino.count);
        for (int i = 0; i <  arrayOfTAlarm.count; i++)
        {
            NSLog(@"%d",lnum);
            
            if(lnum<=0){
                NSString *bus=[[arrayOfTAlarm objectAtIndex:i] busName];
                if(![bus isEqualToString:@"null"])
                {
                    
                    NSLog(@"%@",bus);
                    NSLog(@"the idx is:%i",[arrayArduino indexOfObject:bus]);
                    
                    int index = [arrayArduino indexOfObject: bus];
                    NSLog(@"%d",index);
                    
                    NSNumber *numberLatitude  = [arrayLatitude objectAtIndex:index];
                    NSNumber *numberLongitude = [arrayLongitude objectAtIndex:index];
                    
                    
                    if(lnum==0){
                        lon=numberLongitude;
                        lat=numberLatitude;
                        lnum=lnum-1;
                    }
                    
                    NSLog(@"lon=%@",lon);
                    NSLog(@"lat=%@",lat);
                    
                    NSLog(@"latit=%@",numberLongitude);
                    NSLog(@"long=%@",numberLatitude);
                    
                    
                    NSLog(@"%d", numberLatitude.intValue-lat.intValue);
                    
                    if((lon.intValue==numberLongitude.intValue)&&(lat.intValue == numberLatitude.intValue ))
                    {
                        lon=numberLongitude;
                        lat=numberLatitude;
                    }
                    else sec=0;
                    
                    NSLog(@"sec=%d",sec);
                    if(sec ==30){
                        if(lnot!=0){
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alarm On"
                                                                                message:[NSString stringWithFormat:@"%@ is stopping for long time",bus]
                                                                               delegate:self
                                                                      cancelButtonTitle:@"Cancel"
                                                                      otherButtonTitles:@"OK", nil];
                            [alertView show];
                            lend=0;
                            //UILocalNotification* localNotification = [[UILocalNotification alloc] init];
                            //localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:60];
                            //localNotification.alertBody = ;
                            //localNotification.timeZone = [NSTimeZone defaultTimeZone];
                            //[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                            if(lnot !=0) lnot --;
                        }
                    }
                    
                }
                
            }
            
        }
    }
    sec=sec+5;
    if(lnum !=0)
        lnum --;
    NSLog(@"lnum=%d",lnum);
    [arrayArduino removeAllObjects];
    [arrayLongitude removeAllObjects];
    [arrayLatitude removeAllObjects];
    
    
}
@end

