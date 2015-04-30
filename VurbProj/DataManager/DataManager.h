//
//  DataManager.h
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationManager.h"
#import "Client.h"
#import "CardModel.h"

//This class is the layer that connects the "server" with the view and manages all the models.

@interface DataManager : NSObject <LocationMangerDelegate, ClientDelegate>

/**
 * gets singleton object.
 * @return singleton
 */
+ (DataManager*)sharedInstance;

@property (nonatomic, strong) NSMutableOrderedSet* cards;

/*!
 * call to asynchronously in order to fetch cards data
 */
-(BOOL) refreshCards;

/*!
 * get the location string. Not gaurenteed to return valid string if called at wrong time.
 */
-(NSString*) locationString;

/*!
 * get the card models in array form
 */
-(NSMutableArray*) getArrayOfCards;

/*!
 * delete a card from the app
 */
-(void) deleteCard:(CardModel*) card;

@end
