//
//  LocationTimerViewController.h
//  LocationTracker
//
//  Created by Mengyi Zhou on 6/6/13.
//  Copyright (c) 2013 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationTimerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btn_get;
@property (weak, nonatomic) IBOutlet UITextView *txt_show;
- (IBAction)btn_pressed:(id)sender;

@end
