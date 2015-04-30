//
//  LocationManager.h
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

//This is a wrapper for Apples location library

@protocol LocationMangerDelegate
-(void) locationUpdated;
-(void) locationEnabled;

@end
@interface LocationManager : NSObject <CLLocationManagerDelegate>
@property (atomic, strong) CLLocation* currentLocation;
@property id <LocationMangerDelegate> delegate;
@end
