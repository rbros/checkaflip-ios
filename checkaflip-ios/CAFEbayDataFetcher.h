//
//  CAFEbayDataFetcher.h
//  checkaflip-ios
//
//  Created by caf on 12/1/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CAFEbaySearchResult.h"

@interface CAFEbayDataFetcher : NSObject
{
}

- (CAFEbaySearchResult*) search:(NSString*) key;

@end
