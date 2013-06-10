//
//  OperationViewController.h
//  LocationTracker
//
//  Created by XUXU on 13-6-7.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *info;
@property NSNumber *ReceiveLatitude;
@property NSNumber *ReceiveLongitude;
- (IBAction)ShowOnMap:(id)sender;

@end