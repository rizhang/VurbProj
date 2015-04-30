//
//  PlaceCardModel.m
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import "PlaceCardModel.h"

@implementation PlaceCardModel

-(void) getCustomUIViewWithView: (UIView*) viewToUpdate;
{
    UILabel* label = [[UILabel alloc] init];
    label.text = self.categoryString;
    [label sizeToFit];
    [viewToUpdate addSubview:label];
}

-(BOOL) isEqualToCards: (CardModel*) card
{
    if(![self isKindOfClass:[card class]] ) {
        return NO;
    }
    
    if(![self.title isEqualToString:card.title] || ![self.thumbNailUrl isEqualToString:card.thumbNailUrl]) {
        return NO;
    }
    
    PlaceCardModel* pCard = (PlaceCardModel*) card;
    
    if(![self.categoryString isEqualToString:pCard.categoryString]) {
        return NO;
    }
    
    return YES;
}

-(NSUInteger) hash
{
    NSUInteger val = [self.title hash] ^ [self.categoryString hash] ^[self.thumbNailUrl hash];
    
    NSLog(@"%lu", (unsigned long)val);
    return val;
}


@end
