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
    NSString* _currentValue;
    NSString* _ebayCompletedAvg;
}

- (id) initWithJSONData:(NSData*)json :(NSString*)andEbayAvg
{
    self = [super init];
    
    if (self) {
        _listings = [[NSMutableArray alloc] init];
        _currentValue = @"";
        _ebayCompletedAvg = andEbayAvg;
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
    
    if ([json[@"error"] boolValue] == true) {
        _currentValue = @"Could not find any listings.";
        return;
    }

    _currentValue = [NSString stringWithFormat:@"Value: %@", json[@"medianValue"]];
    NSArray* completedListings = json[@"completedListings"];
    for (NSDictionary* listing in completedListings) {

        NSString* price = listing[@"currentPrice"];
        price = [price substringFromIndex:1]; // remove $

        // Remove "Value:" from "Value: $AVG". It's hackybut I will improve the JSON response info.
        NSString* ebayval = [_ebayCompletedAvg substringFromIndex:8];

        if ([price floatValue] < [ebayval floatValue] / 2) {
            NSString* p = listing[@"currentPrice"];
            p = [NSString stringWithFormat:@"<font color='#f39c12'>%@</font>", p];
            [listing setValue:p forKey:@"currentPrice"];
        }

        CAFListingItem* item = [[CAFListingItem alloc] initWithDict:listing];
        [_listings addObject:item];
    }
}

- (NSArray*) getListings
{
    return _listings;
}

- (NSString*) getCurrentValue
{
    return _currentValue;
}


@end
