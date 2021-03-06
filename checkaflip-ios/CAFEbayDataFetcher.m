//
//  CAFEbayDataFetcher.m
//  checkaflip-ios
//
//  Created by caf on 12/1/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFEbayDataFetcher.h"

@implementation CAFEbayDataFetcher

- (CAFEbaySearchResult*)search:(NSString*) key
{
    // Make http request for JSON.
    NSString* server = [NSString stringWithFormat:@"http://checkaflip.com/searchEbay/?q=%@&new=false&json=true", key];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:server]
                                                        cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];

    [request setHTTPMethod:@"GET"];

    NSError* error;
    NSURLResponse* response = nil;

    NSData* json = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    if (error)
        return nil;

    return [[CAFEbaySearchResult alloc] initWithJSONData:json];
}

@end
