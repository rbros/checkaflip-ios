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

    CAFEbayDataFetcher* ebaydf = [[CAFEbayDataFetcher alloc] init];
    _ebaysr = [ebaydf search:key];
    
    CAFCraigslistDataFetcher* cldf = [[CAFCraigslistDataFetcher alloc] init];
    _clsr = [cldf search:key];

}

- (NSString*) getCurrentSearchKey
{
    return _currentKey;
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