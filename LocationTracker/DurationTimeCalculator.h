//
//  DurationTimeCalculator.h
//  LocationTracker
//
//  Created by Mengyi Zhou on 6/4/13.
//  Copyright (c) 2013 Kettering. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
@interface DurationTimeCalculator : UIViewController<NSURLConnectionDataDelegate>

- (NSString *) getDurationfrom: (Location*) origin to:(Location*) destination;
- (NSString *) getStartAddressFrom:(Location*) origin To:(Location*) destination;
- (NSString *) getEndAddressFrom:(Location*) origin To:(Location*) destination;
- (NSString *) getFormatTime:(int) seconds;
@end
