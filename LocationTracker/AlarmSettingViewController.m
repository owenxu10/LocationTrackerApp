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
{
    NSMutableArray *arrayOfPerson;
    sqlite3 *alarmDB;
    NSString *dbPathString;
}
@end

@implementation AlarmSettingViewController
@synthesize alarmTime = _alarmTime;
@synthesize lblText = _lblText;
@synthesize RepeatDay;
@synthesize StopForLongTime;
@synthesize LongTime;
@synthesize Minutes;
@synthesize time;
@synthesize repeat;
@synthesize busname;

-(void) didDaySelection:(NSMutableArray *)selectedDay{
    RepeatDay.text =@"";
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
    repeat = objects;
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
    busname= self.title;
    [self createOrOpenDB];
}


- (void)createOrOpenDB
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
}



- (IBAction)savePressed:(id)sender {
    LongTime = StopForLongTime.isOn;
    int alarm = (int)floor(_alarmTime.countDownDuration);
     NSString *StringLongTime=nil;
    if (LongTime==YES) {
       StringLongTime = @"YES";
    }
    else{
       StringLongTime = @"NO";
    }
    
    Minutes = [NSNumber numberWithInt:alarm];
   
    
    char *error;
 
        if (sqlite3_open([dbPathString UTF8String], &alarmDB)==SQLITE_OK) {
            NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO ALARMS(BUSNAME,MINUTES,REPEAT,StopForLongTime) values ('%s', '%d','%s','%s')",[busname UTF8String],alarm ,[repeat UTF8String],[StringLongTime UTF8String]];
            
            const char *insert_stmt = [insertStmt UTF8String];
            
            if (sqlite3_exec(alarmDB, insert_stmt, NULL, NULL, &error)==SQLITE_OK) {
                NSLog(@"Alarm added");
                
                //   Person *person = [[Person alloc]init];
                
                //   [person setName:self.nameField.text];
                //  [person setAge:[self.ageField.text intValue]];
                
                // [arrayOfPerson addObject:person];
            }
            sqlite3_close(alarmDB);

        }
    


    
}
@end
