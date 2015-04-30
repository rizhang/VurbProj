//
//  CardModel.m
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import "CardModel.h"

@implementation CardModel

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CardModel class]]) {
        return NO;
    }
    
    return [self isEqualToCards:(CardModel* )object];
}

-(BOOL) isEqualToCards: (CardModel*) card
{
    if(![self isKindOfClass:[card class]] ) {
        return NO;
    }
    
    if(![self.title isEqualToString:card.title] || ![self.thumbNailUrl isEqualToString:card.thumbNailUrl]) {
        return NO;
    }
    
    return YES;
}
//this is to suppress the warning
-(void) getCustomUIViewWithView: (UIView*) viewToUpdate
{
    
}


@end
