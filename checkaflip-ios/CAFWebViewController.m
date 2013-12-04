//
//  CAFWebViewController.m
//  checkaflip-ios
//
//  Created by caf on 12/3/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFWebViewController.h"

@interface CAFWebViewController ()
{
    NSURL* _url;
}

@end

@implementation CAFWebViewController
- (IBAction)back:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void) initialize:(NSURL*) withURL:(NSString*) andTitle
{
    _url = withURL;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:_url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
