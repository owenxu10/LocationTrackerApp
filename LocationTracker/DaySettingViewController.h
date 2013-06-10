//
//  DaySettingViewController.h
//  LocationTracker
//
//  Created by Mengyi Zhou on 6/8/13.
//  Copyright (c) 2013 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlarmSettingDelegate <NSObject>
@optional
-(void) didDaySelection:(NSMutableArray *) selectedDay;
@end

@interface DaySettingViewController : UITableViewController< UITableViewDelegate,  UITableViewDataSource>
@property (nonatomic) id<AlarmSettingDelegate> delegate;
@end
