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
    NSString* _currentValue;
    NSString* _completedValue;
}

- (id) initWithJSONData:(NSData*) json;
{
    self = [super init];

    if (self) {
        _completedListings = [[NSMutableArray alloc] init];
        _currentListings = [[NSMutableArray alloc] init];
        _currentValue = @"";
        _completedValue = @"";
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
    
    if ([json[@"completedError"] boolValue] == true) {
        
        _completedValue = @"Could not find any completed listings.";
    } else {

        _completedValue = json[@"completedPrice"];
    }

    NSArray* completedListings = json[@"completedListings"];
    for (NSDictionary* listing in completedListings) {
        
        CAFListingItem* item = [[CAFListingItem alloc] initWithDict:listing];
        [_completedListings addObject:item];
    }
    
    if ([json[@"currentError"] boolValue] == true) {
        
        _currentValue = @"Could not find any current listings.";
    } else {
        
        _currentValue = json[@"currentPrice"];
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

- (NSString*) getCompletedValue
{
    return _completedValue;
}

- (NSArray*) getCurrentListings
{
    return _currentListings;
}

- (NSString*) getCurrentValue
{
    return _currentValue;
}

@end
