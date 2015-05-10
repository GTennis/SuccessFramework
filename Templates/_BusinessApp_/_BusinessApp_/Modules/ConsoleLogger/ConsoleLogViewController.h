//
//  ConsoleLogViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseViewController.h"
#import "GMConsoleLogger.h"

@interface ConsoleLogViewController : BaseViewController <GMConsoleLoggerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)closePressed:(id)sender;
- (IBAction)clearLogPressed:(id)sender;
- (IBAction)reportPressed:(id)sender;

@end
