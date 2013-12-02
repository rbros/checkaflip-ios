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
    NSString* serverAddress = @"http://checkaflip.com/searchEbay/?q=suit&new=false&json=true";
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:serverAddress]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    [request setHTTPMethod:@"GET"];
    
    NSError* error;
    NSURLResponse* response = nil;
    
    NSData* json = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString* jsonstr = [[NSString alloc] initWithData:json encoding:NSASCIIStringEncoding];
    return [[CAFEbaySearchResult alloc] init];
}

@end
