//
//  CAFCraigslistSearchResult.m
//  checkaflip-ios
//
//  Created by caf on 12/1/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFCraigslistSearchResult.h"
#import "CAFListingItem.h"

@implementation CAFCraigslistSearchResult
{
    NSMutableArray* _listings;
    NSString* _currentPrice;
}

- (id) initWithJSONData:(NSData*) json;
{
    self = [super init];
    
    if (self) {
        _listings = [[NSMutableArray alloc] init];
        _currentPrice = @"DKFJDF";
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
    
    if ([json[@"error"] boolValue] == true)
        return;
    
    _currentPrice = json[@"medianValue"];
    NSArray* completedListings = json[@"completedListings"];
    for (NSDictionary* listing in completedListings) {
        CAFListingItem* item = [[CAFListingItem alloc] initWithDict:listing];
        [_listings addObject:item];
    }
}

- (NSArray*) getListings
{
    return _listings;
}

- (NSString*) getCurrentPrice
{
    return _currentPrice;
}


@end
