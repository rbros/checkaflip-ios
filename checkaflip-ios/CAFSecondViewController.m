//
//  CAFSecondViewController.m
//  checkaflip-ios
//
//  Created by caf on 11/30/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFAppDelegate.h"
#import "CAFSecondViewController.h"
#import "CAFCraigslistSearchResult.h"
#import "CAFListingItem.h"

@interface CAFSecondViewController ()

@end

@implementation CAFSecondViewController
{
    CAFCraigslistSearchResult* _clsr;
}

- (void) viewDidAppear:(BOOL)animated
{
    CAFAppDelegate* app = (CAFAppDelegate*)[[UIApplication sharedApplication] delegate];
    CAFDataFetcher* df = app.getDataFetcher;
    
    self.searchBar.text = df.getCurrentSearchKey;
    self.slider.on = df.getNew;
    
    _clsr = df.getCraigslistSearchResult;
    [self.tableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // this callback can be moved to a shared delegate between craigslist and ebay tabs to always store datas at a high level.

    // set list loading icon.
    
    // load data from http
    CAFAppDelegate* app = (CAFAppDelegate*)[[UIApplication sharedApplication] delegate];
    CAFDataFetcher* df = app.getDataFetcher;
    [df search:self.searchBar.text:self.slider.isOn];
    _clsr = df.getCraigslistSearchResult;
    
    [self.tableView reloadData];
    [self.searchBar resignFirstResponder];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (_clsr) {
        CAFListingItem* item = [[_clsr getListings] objectAtIndex:indexPath.row];
        cell.textLabel.text = [item getTitle];
    }
    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_clsr) {
        return [[_clsr getListings] count];
    }
    
    return 0;
}

@end

