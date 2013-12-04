//
//  CAFListingItem.h
//  checkaflip-ios
//
//  Created by caf on 12/1/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAFListingItem : NSObject

- (id) initWithDict:(NSDictionary*) json;
- (NSString*) getTitle;
- (NSString*) getImgURL;

@end
