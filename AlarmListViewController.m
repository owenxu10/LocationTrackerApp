//
//  AlarmListViewController.m
//  LocationTracker
//
//  Created by Trees on 13-6-12.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import "AlarmListViewController.h"
#import "sqlite3.h"

@interface AlarmListViewController ()
{
    NSMutableArray *arrayOfAlarm;
    sqlite3 *alarmDB;
    NSString *dbPathString;
}

@end

@implementation AlarmListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrayOfAlarm = [[NSMutableArray alloc]init];
    [self createOrOpenDB];
    [self GetDataFromDB];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return arrayOfAlarm.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Alarm *alarm = [arrayOfAlarm objectAtIndex:indexPath.row];
    NSLog(@"%@",alarm.busName);
    cell.textLabel.text = alarm.busName;
    
    
    return cell;

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
        
            
          

-(void)GetDataFromDB {
    
    sqlite3_stmt *statement;
    
    if (sqlite3_open([dbPathString UTF8String], &alarmDB)==SQLITE_OK) {
        [arrayOfAlarm removeAllObjects];
        
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM ALARMS"];
        const char* query_sql = [querySql UTF8String];
        
        if (sqlite3_prepare(alarmDB, query_sql, -1, &statement, NULL)==SQLITE_OK) {
            while (sqlite3_step(statement)==SQLITE_ROW) {
                NSString *busnamedb = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *minutes = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *repeat = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *StayForLongTime = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                
                
                
                Alarm *alarm = [[Alarm alloc]init];
                [alarm setBusName:busnamedb];
                [alarm setMinutes:[minutes intValue]];
                [alarm setRepeat:repeat];
                [alarm setLongTime: StayForLongTime];
                
                //NSLog(@"%@",alarm.busName);
                //NSLog(@"%d",alarm.minutes);
                //NSLog(@"%@",alarm.LongTime);
                //NSLog(@"%@",alarm.Repeat);
                
                [arrayOfAlarm addObject:alarm];
                //NSLog(@"%d",arrayOfAlarm.count);
            }
        }
    }
    [[self TableView]reloadData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
