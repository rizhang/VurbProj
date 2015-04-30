//
//  CardFactory.m
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import "CardFactory.h"
#import "PlaceCardModel.h"
#import "MusicCardModel.h"
#import "MovieCardModel.h"
@implementation CardFactory
+(CardModel*) createCardWithType: (NSString*) type
{
    if([type isEqualToString:  @"place"]) {
        return [PlaceCardModel new];
    } else if([type isEqualToString:@"movie"] ) {
        return [MovieCardModel new];
    } else if([type isEqualToString:@"music"] ){
        return [MusicCardModel new];
    }
    return nil;
}

+(void) setRemainingValuesWithCard: (CardModel*) model cardData: (NSDictionary*) cardData
{
    if([model isKindOfClass: [PlaceCardModel class]]) {
        PlaceCardModel* pcm = (PlaceCardModel*) model;
        pcm.categoryString = cardData[@"placeCategory"];
    } else if([model isKindOfClass:[MusicCardModel class]]) {
        MusicCardModel* mcm = (MusicCardModel*) model;
        mcm.videoLinkUrl = cardData[@"musicVideoURL"];
    } else if([model isKindOfClass: [MovieCardModel class]]) {
        MovieCardModel* mocm = (MovieCardModel*) model;
        mocm.actorMovieImageUrl = cardData[@"movieExtraImageURL"];
    }
}


@end
