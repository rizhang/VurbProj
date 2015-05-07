    //
//  LocationManager.m
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import "LocationManager.h"
#import <UIKit/UIKit.h>

@interface LocationManager()
{
    CLLocationManager *locationManager;
}
@end
@implementation LocationManager

-(id) init
{
    self = [super init];
    if(self) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            [locationManager requestWhenInUseAuthorization];
        
        [locationManager startUpdatingLocation];
    }
    
    return self;
}

#pragma mark - Locantion manager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation* newLocation = [locations lastObject];
    if(newLocation != nil) {
        [_delegate locationUpdated];
    }
    self.currentLocation = newLocation;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_delegate locationEnabled];
    }
}

@end
