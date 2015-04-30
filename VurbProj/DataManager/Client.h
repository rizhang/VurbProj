//
//  Client.h
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
//I created this so all network calls can be handled here. Location Manager is a GPS kind of thing so
//I didn't put the logic in here
@protocol ClientDelegate <NSObject>
-(void) jsonHasBeenFetched:(NSData*) jsonData;

@end
@interface Client : NSObject <NSURLConnectionDelegate>
@property id <ClientDelegate> delegate;
-(void) fetchCards;

@end
