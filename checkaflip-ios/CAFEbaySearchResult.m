//
//  CAFEbaySearchResult.m
//  checkaflip-ios
//
//  Created by caf on 12/1/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFEbaySearchResult.h"

@implementation CAFEbaySearchResult
{
    NSArray* _completedListings;
    NSArray* _currentListings;
}

- (id) initWithJSONStr:(NSString*) json;
{
    self = [super init];
    
    if (self) {
        _completedListings = [NSArray arrayWithObjects: @"eBay", nil];
        _currentListings = [NSArray arrayWithObjects: @"eBay_completed", nil];
    }
    return self;
}

- (void) parseJSON:(NSString*) json
{
    
}

- (NSArray*) getCompletedListings
{
    return _completedListings;
}

- (NSArray*) getCurrentListings
{
    return _currentListings;
}

@end
