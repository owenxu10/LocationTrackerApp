//
//  Location.h
//  LocationTracker
//
//  Created by Mengyi Zhou on 6/5/13.
//  Copyright (c) 2013 Kettering. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject
{
    float longitude;
    float latitude;
}

- (float) longitude;
- (void) setLongitude:  (float)value;
- (float) latitude;
- (void) setLatitude: (float)value;
@end
