//
//  AlarmDetailViewController.h
//  LocationTracker
//
//  Created by Trees on 13-6-12.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmDetailViewController : UIViewController


@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
