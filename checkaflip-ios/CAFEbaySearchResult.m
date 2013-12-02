//
//  CAFEbaySearchResult.m
//  checkaflip-ios
//
//  Created by caf on 12/1/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFEbaySearchResult.h"
#import "CAFListingItem.h"

@implementation CAFEbaySearchResult
{
    NSMutableArray* _completedListings;
    NSMutableArray* _currentListings;
}

- (id) initWithJSONData:(NSData*) json;
{
    self = [super init];

    if (self) {
        _completedListings = [[NSMutableArray alloc] init];
        _currentListings = [[NSMutableArray alloc] init];
        [self parseJSON:json];
    }
    return self;
}

- (void) parseJSON:(NSData*) jsondata
{
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"JSONObjectWithData error: %@", error);
        return;
    }

    NSArray* completedListings = json[@"completedListings"];
    for (NSDictionary* listing in completedListings) {
        NSString* title = listing[@"title"];
        
        CAFListingItem* item = [[CAFListingItem alloc] initWithDict:listing];
        [_completedListings addObject:item];
    }
    
    NSArray* currentListings = json[@"currentListings"];
    for (NSDictionary* listing in currentListings) {
        CAFListingItem* item = [[CAFListingItem alloc] initWithDict:listing];
        [_currentListings addObject:item];
    }
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
