//
//  CAFFirstViewController.m
//  checkaflip-ios
//
//  Created by caf on 11/30/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFFirstViewController.h"


@interface CAFFirstViewController ()
@end

@implementation CAFFirstViewController
- (IBAction)searchTextView:(UITextField *)sender {
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@", self.searchTextView.text);
    [self.searchTextView resignFirstResponder];
    return YES;
}

@end
