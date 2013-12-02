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

- (NSArray*) getCompletedListings
{
    return _completedListings;
}

- (NSArray*) getCurrentListings
{
    return _currentListings;
}

@end
