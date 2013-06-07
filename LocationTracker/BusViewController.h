//
//  BusViewController.h
//  LocationTracker
//
//  Created by XUXU on 13-6-2.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITableView *showAllBus;
- (IBAction)refresh:(id)sender;



@end
