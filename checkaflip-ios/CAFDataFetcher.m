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

@implementation CAFDataFetcher
{
    CAFEbaySearchResult* _ebaysr;
}

- (id) init
{
    self = [super self];
    return self;
}

- (void) search:(NSString*)key
{
    CAFEbayDataFetcher* ebaydf = [[CAFEbayDataFetcher alloc] init];
    _ebaysr = [ebaydf search:key];

}

- (CAFEbaySearchResult*) getEbaySearchResult
{
    return _ebaysr;
}

@end
