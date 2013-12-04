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
    [self update];
}

- (void) onSearchComplete:(NSNotification*) noti
{
    CAFAppDelegate* app = (CAFAppDelegate*)[[UIApplication sharedApplication] delegate];
    CAFDataFetcher* df = app.getDataFetcher;
    _ebaysr = df.getEbaySearchResult;
    [self update];
}

- (void) updateValueLabel
{
    if (_ebaysr && self.ebaySegmentedControl.selectedSegmentIndex == 0) {
        self.valueLabel.text = _ebaysr.getCompletedValue;
    } else if (_ebaysr) {
        self.valueLabel.text = _ebaysr.getCurrentValue;
    }
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
    
    CAFListingItem* item = nil;
    if (_ebaysr && self.ebaySegmentedControl.selectedSegmentIndex == 0) {

        item = [[_ebaysr getCompletedListings] objectAtIndex:indexPath.row];
    } else if (_ebaysr) {
        item = [[_ebaysr getCurrentListings] objectAtIndex:indexPath.row];
    }

    if (item) {
        cell.textLabel.text = [item getTitle];
        cell.imageView.image = nil; // [UIImage imageName:@"placeholder.jpg"

        /* Async load image. */
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0ul), ^{
            NSData* imgdata = [NSData dataWithContentsOfURL: [NSURL URLWithString:[item getImgURL]]];
            UIImage* img = [UIImage imageWithData:imgdata];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = img;
                [cell setNeedsLayout];
            });
        });
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
    
    [self updateValueLabel];
    return count;
}

@end
