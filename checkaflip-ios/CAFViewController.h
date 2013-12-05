//
//  CAFViewController.h
//  checkaflip-ios
//
//  Created by caf on 12/2/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAFViewController : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UISearchBar* searchBar;
@property (strong, nonatomic) IBOutlet UIButton* usedNewButton;
@property (strong, nonatomic) IBOutlet UILabel* valueLabel;
@property (strong, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView* progressView;

- (void) update;
- (void) updateValueLabel;
- (void) onSearchStart:(NSNotification*)noti;
- (void) onSearchComplete:(NSNotification*)noti;
- (NSArray*) getDisplayedListings;

@end
