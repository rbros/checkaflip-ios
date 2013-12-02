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
- (IBAction)onSliderChange:(UISwitch *)sender {

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

- (void) viewDidAppear:(BOOL)animated
{
    CAFAppDelegate* app = (CAFAppDelegate*)[[UIApplication sharedApplication] delegate];
    CAFDataFetcher* df = app.getDataFetcher;
    
    self.searchBar.text = df.getCurrentSearchKey;
    self.slider.on = df.getNew;
    
    _clsr = df.getCraigslistSearchResult;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) dismissKeyboard {
    [self.searchBar resignFirstResponder];
}

-(void) searchBar:(UISearchBar*)searchBar textDidChange:(NSString *)searchText
{
    // load data from http
    CAFAppDelegate* app = (CAFAppDelegate*)[[UIApplication sharedApplication] delegate];
    CAFDataFetcher* df = app.getDataFetcher;
    [df setCurrentSearchKey:searchText];
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
    
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (_clsr) {
        CAFListingItem* item = [[_clsr getListings] objectAtIndex:indexPath.row];
        cell.textLabel.text = [item getTitle];
    }
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_clsr) {
        return [[_clsr getListings] count];
    }
    
    return 0;
}

@end

