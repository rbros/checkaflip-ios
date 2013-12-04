//
//  CAFListingItem.m
//  checkaflip-ios
//
//  Created by caf on 12/1/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFListingItem.h"

@implementation CAFListingItem {
    
    NSString* _title;
    NSString* _currentPrice;
    NSString* _link;
    NSString* _img;
}

- (id) initWithDict:(NSDictionary*) dict
{
    self = [super init];
    if (self) {
        _title = dict[@"title"];
        _currentPrice = dict[@"currentPrice"];
        _link = dict[@"link"];
        
        _img = @"";
        if (dict[@"imageURL"]) {
            _img = dict[@"imageURL"];
        }
    }
    
    return self;
}

- (NSString*) getTitle
{
    return _title;
}

- (NSString*) getImgURL
{
    return _img;
}

@end
