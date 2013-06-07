//
//  CountViewController.h
//  Timer
//
//  Created by XUXU on 13-6-5.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountViewController : UIViewController{

    NSTimer *Timer;
}
@property NSString *data;
@property int duration;
@property (weak, nonatomic) IBOutlet UILabel *get;

@end
