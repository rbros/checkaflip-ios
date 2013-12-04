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

- (void) viewWillAppear:(BOOL)animated
{
    CAFAppDelegate* app = (CAFAppDelegate*)[[UIApplication sharedApplication] delegate];
    CAFDataFetcher* df = app.getDataFetcher;
    
    self.searchBar.text = df.getCurrentSearchKey;
    self.slider.on = df.getNew;
    
    _clsr = df.getCraigslistSearchResult;
    [self update];
}

- (void) onSearchComplete:(NSNotification*) noti
{
    CAFAppDelegate* app = (CAFAppDelegate*)[[UIApplication sharedApplication] delegate];
    CAFDataFetcher* df = app.getDataFetcher;
    _clsr = df.getCraigslistSearchResult;
    [self update];
}

- (void) updateValueLabel
{
    self.valueLabel.text = _clsr.getCurrentValue;
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    CAFAppDelegate* app = (CAFAppDelegate*)[[UIApplication sharedApplication] delegate];
    CAFDataFetcher* df = app.getDataFetcher;
    [df search:self.searchBar.text:self.slider.isOn];

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

