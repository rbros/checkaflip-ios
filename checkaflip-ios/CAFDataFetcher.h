//
//  CAFDataFetcher.h
//  checkaflip-ios
//
//  Created by caf on 12/1/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CAFEbaySearchResult.h"

@interface CAFDataFetcher : NSObject

- (void) search:(NSString*) key;
- (CAFEbaySearchResult*) getEbaySearchResult;

@end
