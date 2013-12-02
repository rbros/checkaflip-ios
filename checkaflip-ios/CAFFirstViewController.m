//
//  CAFFirstViewController.m
//  checkaflip-ios
//
//  Created by caf on 11/30/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import "CAFFirstViewController.h"
#import "CAFEbayDataFetcher.h"
#import "CAFEbaySearchResult.h"

@interface CAFFirstViewController ()
@end

@implementation CAFFirstViewController
{
    CAFEbaySearchResult* _ebaysr;
}
- (IBAction)onSegmentControlChanged:(UISegmentedControl *)sender {
    [self.tableView reloadData];
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

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // this callback can be moved to a shared delegate between craigslist and ebay tabs to always store datas at a high level.
    
    NSLog(@"You entered %@", self.searchBar.text);
    
    // set list loading icon.
    
    // load data from http
    CAFEbayDataFetcher* ebaydf = [[CAFEbayDataFetcher alloc] init];
    _ebaysr = [ebaydf search: self.searchBar.text];

    // populate completed and current lists
    [self.searchBar resignFirstResponder];
}

- (UITableViewCell*) tableView:(UITableViewCell*) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (self.ebaySegmentedControl.selectedSegmentIndex == 0) {
        cell.textLabel.text = @"EBAY";
    } else {
        cell.textLabel.text = @"EBAY_CURRENT";
    }

    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.ebaySegmentedControl.selectedSegmentIndex == 0) {
        return [[_ebaysr getCompletedListings] count];
    } else {
        return [[_ebaysr getCurrentListings] count];
    }
}
@end
