//
//  ViewController.m
//  Timer
//
//  Created by XUXU on 13-6-5.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize time;
@synthesize duration;

- (void)viewDidLoad
{
    [super viewDidLoad];
    	// Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)set:(id)sender { 
       // NSLog(@"time=%f",time.countDownDuration);
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     duration = (int)floor(time.countDownDuration);
   
    UIViewController *send = segue.destinationViewController;
    NSString *string = [NSString stringWithFormat:@"%d", duration];

    if([send respondsToSelector:@selector(setData:)])
    [send setValue:string forKey: @"data"];
}
@end
