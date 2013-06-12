//
//  DurationTimeCalculator.h
//  LocationTracker
//
//  Created by Mengyi Zhou on 6/4/13.
//  Copyright (c) 2013 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
@interface DurationTimeCalculator : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btn_get;
@property (weak, nonatomic) IBOutlet UITextView *txt_response;

- (IBAction)btn_pressed:(id)sender;
- (NSString *) getDurationfrom: (Location*) origin to:(Location*) destination;
- (NSString *) getStartAddressFrom:(Location*) origin To:(Location*) destination;
- (NSString *) getEndAddressFrom:(Location*) origin To:(Location*) destination;
- (NSString *) getFormatTime:(int) seconds;
@end
