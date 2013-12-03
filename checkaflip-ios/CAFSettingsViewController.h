//
//  CAFSettingsViewController.h
//  checkaflip-ios
//
//  Created by caf on 12/2/13.
//  Copyright (c) 2013 CheckAFlip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAFSettingsViewController : UIViewController <UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIButton *selectCityButton;
@property (strong, nonatomic) IBOutlet UISwitch *manualCitySwitch;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;

@end
