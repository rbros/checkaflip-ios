//
//  CAFFirstViewController.h
//  checkaflip-ios
//
//  Created by caf on 11/30/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAFFirstViewController : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UISearchBar* searchBar;
@property (strong, nonatomic) IBOutlet UISegmentedControl* ebaySegmentedControl;
@property (strong, nonatomic) IBOutlet UITableView* tableView;

@end
