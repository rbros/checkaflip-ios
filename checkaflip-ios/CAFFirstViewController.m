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
#import "CAFWebViewController.h"

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
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"EbayCellIdent"];
    
    CAFListingItem* item = nil;
    if (_ebaysr && self.ebaySegmentedControl.selectedSegmentIndex == 0) {

        item = [[_ebaysr getCompletedListings] objectAtIndex:indexPath.row];
    } else if (_ebaysr) {
        item = [[_ebaysr getCurrentListings] objectAtIndex:indexPath.row];
    }

    if (item) {
        
        UIImageView* imgholder = (UIImageView*) [cell.contentView viewWithTag:1];
        UITextView* titlelabel = (UITextView*) [cell.contentView viewWithTag:2];
        UIWebView* pricelabel = (UIWebView*) [cell.contentView viewWithTag:3];

        titlelabel.text = [item getTitle];
        [pricelabel loadHTMLString:[item getPrice] baseURL:[NSURL URLWithString:@"" ]];
        
        // if img is null set placeholder and make dispatch_asnyc
        //imgholder.image = nil; // [UIImage imageName:@"placeholder.jpg"

        /* Async load image. */
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0ul), ^{
            NSData* imgdata = [NSData dataWithContentsOfURL: [NSURL URLWithString:[item getImgURL]]];
            UIImage* img = [UIImage imageWithData:imgdata];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [imgholder setImage:img]; // = img;
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

- (NSArray*) getDisplayedListings
{
    if (_ebaysr && self.ebaySegmentedControl.selectedSegmentIndex == 0) {
        return [_ebaysr getCompletedListings];
    } else if (_ebaysr) {
        return [_ebaysr getCurrentListings];
    }
    return nil;
}

@end
