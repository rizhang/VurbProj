//
//  MovieCardModel.m
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import "MovieCardModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MovieCardModel
-(void) getCustomUIViewWithView: (UIView*) viewToUpdate
{
    //placeholder
    CGFloat height = CGRectGetHeight(viewToUpdate.frame);
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,height , height)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [viewToUpdate addSubview:imageView];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.actorMovieImageUrl] options:SDWebImageHighPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [imageView setImage:image];
    }];
    NSLog(@"movie");
    
}

-(BOOL) isEqualToCards: (CardModel*) card
{
    if(![self isKindOfClass:[card class]] ) {
        return NO;
    }
    
    if(![self.title isEqualToString:card.title] || ![self.thumbNailUrl isEqualToString:card.thumbNailUrl]) {
        return NO;
    }
    
    MovieCardModel* mCard = (MovieCardModel*) card;
    if(![self.actorMovieImageUrl isEqualToString:mCard.actorMovieImageUrl]) {
        return NO;
    }
    
    return YES;
}

-(NSUInteger) hash
{
    NSUInteger val = [self.title hash] ^ [self.actorMovieImageUrl hash] ^[self.thumbNailUrl hash];
    
    NSLog(@"%lu", (unsigned long)val);
    return val;
}

@end
