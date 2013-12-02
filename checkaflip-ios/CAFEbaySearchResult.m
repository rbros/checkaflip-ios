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
    NSMutableArray* _completedListings;
    NSMutableArray* _currentListings;
}

- (id) initWithJSONStr:(NSData*) json;
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
        [_completedListings addObject:title];
    }
    
    NSArray* currentListings = json[@"currentListings"];
    for (NSDictionary* listing in currentListings) {
        [_currentListings addObject:listing[@"title"]];
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
