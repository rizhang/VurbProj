//
//  CardFactory.h
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardModel.h"

//This class handles all the unique initializations that needs to happen for different cards.
//I want to have all this happen in one place since it can get messy
@interface CardFactory : NSObject
/*!
 * return correct subclass of CardModel. If the type is invalid, will return nil
 */
+(CardModel*) createCardWithType: (NSString*) type;


/*!
 * set any remaining data for various card models
 */
+(void) setRemainingValuesWithCard: (CardModel*) model cardData: (NSDictionary*) cardData;



@end
