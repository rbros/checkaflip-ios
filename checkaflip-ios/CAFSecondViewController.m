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
    self.usedNewButton.selected = df.getNew;
    
    _clsr = df.getCraigslistSearchResult;
    [self update];
}

- (void) onSearchComplete:(NSNotification*) noti
{
    [super onSearchComplete:noti];

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
    [df search:self.searchBar.text:self.usedNewButton.selected];

    [self.searchBar resignFirstResponder];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CLCellIdent"];
    
    if (_clsr) {
        CAFListingItem* item = [[self getDisplayedListings] objectAtIndex:indexPath.row];
        
        UITextView* titlelabel = (UITextView*) [cell.contentView viewWithTag:2];
        UIWebView* pricelabel = (UIWebView*) [cell.contentView viewWithTag:3];
        
        titlelabel.text = [item getTitle];
        [pricelabel loadHTMLString:[NSString stringWithFormat:@"<div align='right' style='font-size: 13px; font-weight: 500;'>%@<div>",[item getPrice]] baseURL:[NSURL URLWithString:@"" ]];
    }
    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_clsr)
        return [[_clsr getListings] count];
    
    return 0;
}

- (NSArray*) getDisplayedListings
{
    if (_clsr)
        return [_clsr getListings];

    return nil;
}

@end

