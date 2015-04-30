//
//  Client.m
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import "Client.h"

NSString* CARD_URL = @"https://gist.githubusercontent.com/helloandrewpark/0a407d7c681b833d6b49/raw/5f3936dd524d32ed03953f616e19740bba920bcd/gistfile1.js";
NSString* TEST_URL = @"https://api.myjson.com/bins/3zb95";
NSString* TEST_URL2 = @"https://api.myjson.com/bins/41gex";
NSString* TEST_URL3 = @"https://api.myjson.com/bins/5ags9";

@interface Client()
{
    NSMutableData *_cardResponseData;
    NSURLConnection* cardFetchConnection;
}

@end
@implementation Client

-(void) fetchCards
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:CARD_URL]];
    
    cardFetchConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

}


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if(connection == cardFetchConnection)
        _cardResponseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(connection == cardFetchConnection)
        [_cardResponseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [_delegate jsonHasBeenFetched:_cardResponseData];

}

@end
