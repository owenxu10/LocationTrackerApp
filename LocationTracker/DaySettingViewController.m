//
//  DaySettingViewController.m
//  LocationTracker
//
//  Created by Mengyi Zhou on 6/8/13.
//  Copyright (c) 2013 Kettering. All rights reserved.
//

#import "DaySettingViewController.h"
#import "AlarmSettingViewController.h"

@interface DaySettingViewController ()
@property NSMutableArray *selectedDays;
@end

@implementation DaySettingViewController
@synthesize selectedDays = _selectedDays;

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _selectedDays = [[NSMutableArray alloc]initWithCapacity:1];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    NSNumber *wrapper = [NSNumber numberWithInteger:cell.tag];
    [_selectedDays addObject:wrapper];
    [self.delegate didDaySelection:_selectedDays];
    /*
    // Navigation logic may go here. Create and push another view controller.
    
      AlarmSettingViewController *detailViewController = [[AlarmSettingViewController alloc] initWithNibName:@"AlarmSettingViewController" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
}

@end
