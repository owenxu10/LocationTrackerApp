//
//  ViewController.h
//  Timer
//
//  Created by XUXU on 13-6-5.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)set:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *time;
@property int duration;
@end
