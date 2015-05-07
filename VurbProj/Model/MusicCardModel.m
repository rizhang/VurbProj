//
//  MusicCardModel.m
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import "MusicCardModel.h"

@implementation MusicCardModel
-(void) getCustomUIViewWithView: (UIView*) viewToUpdate
{
    CGFloat height = CGRectGetHeight(viewToUpdate.frame);
    CGFloat width = CGRectGetWidth(viewToUpdate.frame);
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchDown];
    [btn setTitle:self.videoLinkUrl forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [viewToUpdate addSubview:btn];
    NSLog(@"music");
}

-(void) btnPressed:(UIButton*) button
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.videoLinkUrl]];
}


-(BOOL) isEqualToCards: (CardModel*) card
{
    if(![self isKindOfClass:[card class]] ) {
        return NO;
    }
    
    if(![self.title isEqualToString:card.title] || ![self.thumbNailUrl isEqualToString:card.thumbNailUrl]) {
        return NO;
    }
    
    MusicCardModel* mCard = (MusicCardModel*) card;
    if(![self.videoLinkUrl isEqualToString:mCard.videoLinkUrl]) {
        return NO;
    }
    
    return YES;
    
}

-(NSUInteger) hash
{
    NSUInteger val = [self.title hash] ^ [self.videoLinkUrl hash] ^ [self.thumbNailUrl hash];

    NSLog(@"%lu", (unsigned long)val);
    return val;
}

@end
