//
//  ContactsViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ContactsViewController.h"
#import <MessageUI/MessageUI.h>

@interface ContactsViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation ContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)emailButtonPressed:(UIButton *)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposeViewController = [MFMailComposeViewController new];
        [mailComposeViewController setToRecipients:@[sender.titleLabel.text]];
        mailComposeViewController.mailComposeDelegate = self;
        [self presentViewController:mailComposeViewController animated:YES completion:nil];
    }
}

- (void)dialPhone:(NSString *)phoneString {
    
    // Prepare url
    NSString *cleanedString = [[phoneString componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", cleanedString]];
    
    // Open url
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)dialPhoneButtonPressed:(UIButton *)sender {
    
    // By convention, it assumes the phone is written on the button
    [self dialPhone:sender.titleLabel.text];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
