//
//  CAFCraigslistSearchResult.m
//  checkaflip-ios
//
//  Created by caf on 12/1/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFCraigslistSearchResult.h"

@implementation CAFCraigslistSearchResult
{
    NSMutableArray* _listings;
}

- (id) initWithJSONData:(NSData*) json;
{
    self = [super init];
    
    if (self) {
        _listings = [[NSMutableArray alloc] init];
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
        [_listings addObject:title];
    }
}

- (NSArray*) getListings
{
    return _listings;
}


@end
