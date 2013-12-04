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
#import "CAFWebViewController.h"
#import "CAFListingItem.h"

@implementation CAFViewController
- (IBAction)onSliderChanged:(UISwitch *)sender {
    
    CAFAppDelegate* app = (CAFAppDelegate*)[[UIApplication sharedApplication] delegate];
    CAFDataFetcher* df = app.getDataFetcher;
    [df setNew:self.slider.isOn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSearchStart:) name:@"SEARCH_START" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSearchComplete:) name:@"SEARCH_COMPLETE" object:nil];
    
	UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void) onSearchStart:(NSNotification*)noti
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.valueLabel setHidden:YES];
        [self.progressView startAnimating];
    });
}

- (void) onSearchComplete:(NSNotification*)noti
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressView stopAnimating];
        [self.valueLabel setHidden:NO];
    });
}

- (void) update
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self updateValueLabel];
    });
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

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    CAFListingItem* item = [[self getDisplayedListings] objectAtIndex:indexPath.row];
    
    if (item){
        NSURL* url = [NSURL URLWithString:[item getLink]];
        
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        CAFWebViewController* webview = [sb instantiateViewControllerWithIdentifier:@"CAFWebViewController"];
        [webview initialize:url];
        [self presentViewController:webview animated:YES completion:nil];
    }
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
