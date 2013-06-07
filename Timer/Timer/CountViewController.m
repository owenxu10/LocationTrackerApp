//
//  CountViewController.m
//  Timer
//
//  Created by XUXU on 13-6-5.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import "CountViewController.h"
@interface CountViewController ()

@end

@implementation CountViewController
@synthesize data;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _duration = [data intValue];
    NSLog(@"data = %@",data);
    NSLog(@"int = %i",_duration);
    self.get.text = [NSString stringWithFormat:@"%i", _duration];
    Timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

-(void) countDown{
    _duration -=1;
    self.get.text = [NSString stringWithFormat:@"%i", _duration];
    if (_duration == 0) {
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
