//
//  CAFDataFetcher.m
//  checkaflip-ios
//
//  Created by caf on 12/1/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFDataFetcher.h"
#import "CAFEbayDataFetcher.h"
#import "CAFEbaySearchResult.h"
#import "CAFCraigslistSearchResult.h"

NSString* cafurl = @"http://checkaflip.com/";

@implementation CAFDataFetcher
{
    NSString* _currentKey;
    BOOL _currentNew;
    CAFEbaySearchResult* _ebaysr;
    CAFCraigslistSearchResult* _clsr;
}

- (id) init
{
    self = [super self];
    return self;
}

- (void) search:(NSString*) key :(BOOL) n
{
    _currentKey = key;
    _currentNew = n;

    _ebaysr = [CAFDataFetcher searchEbay:key:n];
    _clsr = [CAFDataFetcher searchCraigslist:key:n];
}

+ (CAFEbaySearchResult*)searchEbay:(NSString*) key:(BOOL)new
{
    // Make http request for JSON.
    NSString* server = [NSString stringWithFormat:@"%@searchEbay/?q=%@&new=false&json=true", cafurl, key];
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

+ (CAFCraigslistSearchResult*)searchCraigslist:(NSString*) key:(BOOL)new
{
    // Make http request for JSON.
    NSString* server = [NSString stringWithFormat:@"http://checkaflip.com/searchCraigslist/?q=%@&new=false&city=houston&json=true", key];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:server]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    [request setHTTPMethod:@"GET"];
    
    NSError* error;
    NSURLResponse* response = nil;
    
    NSData* json = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // TODO: if error is not null return empty search result.
    return [[CAFCraigslistSearchResult alloc] initWithJSONData:json];
}

- (NSString*) getCurrentSearchKey
{
    return _currentKey;
}

- (void) setCurrentSearchKey:(NSString *)key
{
    _currentKey = key;
}

- (void) setNew:(BOOL)n
{
    _currentNew = n;
}

- (BOOL) getNew
{
    return _currentNew;
}

- (CAFEbaySearchResult*) getEbaySearchResult
{
    return _ebaysr;
}

- (CAFCraigslistSearchResult*) getCraigslistSearchResult
{
    return _clsr;
}

@end
