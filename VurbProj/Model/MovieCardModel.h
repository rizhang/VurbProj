//
//  MovieCardModel.h
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import "CardModel.h"

@interface MovieCardModel : CardModel
@property (nonatomic, strong) NSString* actorMovieImageUrl;
-(void) getCustomUIViewWithView: (UIView*) viewToUpdate;

@end
