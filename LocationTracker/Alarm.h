//
//  Alarm.h
//  LocationTracker
//
//  Created by Trees on 13-6-12.
//  Copyright (c) 2013年 Kettering. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alarm : NSObject

@property(nonatomic, strong)NSString *busName;
@property(assign)int minutes;
@property(nonatomic, strong)NSString *Repeat;
@property(nonatomic, strong)NSString *LongTime;


@end
