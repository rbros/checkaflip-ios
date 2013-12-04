//
//  CAFWebViewController.h
//  checkaflip-ios
//
//  Created by caf on 12/3/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAFWebViewController : UIViewController <UIWebViewDelegate, UINavigationBarDelegate>

@property (strong, nonatomic) IBOutlet UIWebView* webView;

- (void) initialize:(NSURL*)withURL :(NSString*)andTitle;

@end
