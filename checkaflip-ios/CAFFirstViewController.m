//
//  CAFFirstViewController.m
//  checkaflip-ios
//
//  Created by caf on 11/30/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFAppDelegate.h"
#import "CAFFirstViewController.h"
#import "CAFEbayDataFetcher.h"
#import "CAFEbaySearchResult.h"
#import "CAFListingItem.h"

@interface CAFFirstViewController ()
@end

@implementation CAFFirstViewController
{
    CAFEbaySearchResult* _ebaysr;
}
- (IBAction)onSegmentControlChanged:(UISegmentedControl *)sender {
    [self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    CAFAppDelegate* app = (CAFAppDelegate*)[[UIApplication sharedApplication] delegate];
    CAFDataFetcher* df = app.getDataFetcher;
    
    self.searchBar.text = df.getCurrentSearchKey;
    self.slider.on = df.getNew;
    
    _ebaysr = df.getEbaySearchResult;
    [self.tableView reloadData];
    [self updateValueLabel];
}

- (void) updateValueLabel
{
    self.valueLabel.text = _ebaysr.getCurrentPrice;
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // this callback can be moved to a shared delegate between craigslist and ebay tabs to always store datas at a high level.
    
    // set list loading icon.
    
    // load data from http
    CAFAppDelegate* app = (CAFAppDelegate*)[[UIApplication sharedApplication] delegate];
    CAFDataFetcher* df = app.getDataFetcher;
    [df search:self.searchBar.text:self.slider.isOn];
    _ebaysr = df.getEbaySearchResult;
    
    [self.tableView reloadData];
    [self updateValueLabel];
    [self.searchBar resignFirstResponder];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (_ebaysr && self.ebaySegmentedControl.selectedSegmentIndex == 0) {

        CAFListingItem* item = [[_ebaysr getCompletedListings] objectAtIndex:indexPath.row];
        cell.textLabel.text = [item getTitle];
    } else if (_ebaysr) {
        CAFListingItem* item = [[_ebaysr getCurrentListings] objectAtIndex:indexPath.row];
        cell.textLabel.text = [item getTitle];
    }

    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    if (_ebaysr && self.ebaySegmentedControl.selectedSegmentIndex == 0) {
        count = [[_ebaysr getCompletedListings] count];
    } else if (_ebaysr) {
        count = [[_ebaysr getCurrentListings] count];
    }
    
    return count;
}

@end
