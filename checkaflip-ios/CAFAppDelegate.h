//
//  CAFAppDelegate.h
//  checkaflip-ios
//
//  Created by caf on 11/30/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "CAFDataFetcher.h"

@interface CAFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (CAFDataFetcher*) getDataFetcher;

@end
