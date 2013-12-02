//
//  CAFDataFetcher.h
//  checkaflip-ios
//
//  Created by caf on 12/1/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CAFEbaySearchResult.h"
#import "CAFCraigslistSearchResult.h"

@interface CAFDataFetcher : NSObject

- (void) search:(NSString*) key :(BOOL) n;
- (NSString*) getCurrentSearchKey;
- (void) setCurrentSearchKey:(NSString*)key;
- (void) setNew:(BOOL) n;
- (BOOL) getNew;
- (CAFEbaySearchResult*) getEbaySearchResult;
- (CAFCraigslistSearchResult*) getCraigslistSearchResult;

@end
