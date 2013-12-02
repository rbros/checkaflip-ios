//
//  CAFViewController.m
//  checkaflip-ios
//
//  Created by caf on 12/2/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFViewController.h"
#import "CAFAppDelegate.h"
#import "CAFDataFetcher.h"
#

@implementation CAFViewController
- (IBAction)onSliderChanged:(UISwitch *)sender {
    
    CAFAppDelegate* app = (CAFAppDelegate*)[[UIApplication sharedApplication] delegate];
    CAFDataFetcher* df = app.getDataFetcher;
    [df setNew:self.slider.isOn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dismissKeyboard {
    [self.searchBar resignFirstResponder];
}

-(void) searchBar:(UISearchBar*)searchBar textDidChange:(NSString *)searchText
{
    CAFAppDelegate* app = (CAFAppDelegate*)[[UIApplication sharedApplication] delegate];
    CAFDataFetcher* df = app.getDataFetcher;
    [df setCurrentSearchKey:searchText];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

@end
