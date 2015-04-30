//
//  DataManager.m
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import "DataManager.h"
#import "Constants.h"
#import "CardModel.h"
#import "CardFactory.h"
#import "MusicCardModel.h"
@interface DataManager()
{
    Client *client;
    LocationManager *locationManger;
}
@end

@implementation DataManager

static DataManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[DataManager alloc] init];
}

- (id)mutableCopy
{
    return [[DataManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    client = [Client new];
    client.delegate = self;
    locationManger = [LocationManager new];
    [self refreshCards];
    _cards = [NSMutableOrderedSet new];
    locationManger.delegate = self;
    return self;
}

//MARK: - IMPL

-(NSString*) locationString
{
    return [NSString stringWithFormat:@"%f, %f",
            locationManger.currentLocation.coordinate.latitude,
            locationManger.currentLocation.coordinate.longitude];
}

-(BOOL) refreshCards
{
    [client fetchCards];
    return YES;
}

-(CLLocation*) getLocation
{
    return locationManger.currentLocation;
}

-(NSMutableArray*) getArrayOfCards
{
    return [NSMutableArray arrayWithArray: [_cards array]];
}

-(void) deleteCard:(CardModel*) card
{
    [_cards removeObject:card];
}

#pragma mark - Location Manager Delegate

-(void) locationUpdated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotifLocationFound object:nil];
}

-(void) locationEnabled
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotifLocationEnabled object:nil];
}
#pragma mark - Client Delegate

/*!
 * This will parse the json and process it so it can be used in the app
 */
-(void) jsonHasBeenFetched:(NSData *)jsonData
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&localError];
    if (localError != nil) {
        return;
    }
    
    NSArray* cards = parsedObject[@"cards"];
    for(NSDictionary* card in cards) {
        NSString* type = card[@"type"];
        CardModel* cardModel = [CardFactory createCardWithType:type];
        cardModel.title = card[@"title"];
        cardModel.thumbNailUrl = card[@"imageURL"];
        [CardFactory setRemainingValuesWithCard:cardModel cardData:card];

        [_cards addObject:cardModel];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotifCardsFetched object:nil];

    
}

@end
