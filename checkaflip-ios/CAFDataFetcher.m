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
#import "CAFCraigslistDataFetcher.h"
#import "CAFCraigslistSearchResult.h"

@implementation CAFDataFetcher
{
    CAFEbaySearchResult* _ebaysr;
    CAFCraigslistSearchResult* _clsr;
}

- (id) init
{
    self = [super self];
    if (self) {
        _ebaysr = nil;
        _clsr = nil;
    }
    return self;
}

- (void) search:(NSString*)key
{
    CAFEbayDataFetcher* ebaydf = [[CAFEbayDataFetcher alloc] init];
    _ebaysr = [[CAFEbaySearchResult alloc] initWithJSONData:[ebaydf search:key]];
    
    CAFCraigslistDataFetcher* cldf = [[CAFCraigslistDataFetcher alloc] init];
    _clsr = [cldf search:key];
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
