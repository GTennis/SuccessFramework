//
//  LaunchViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "LaunchViewController.h"
#import "AppDelegate.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self prepareUI];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpers

- (void)renderUI {
    
    // Overrride in subclass for customization
    // ...
}

- (void)prepareUI {
    
    [super prepareUI];
    
    // Use and set the same launch image as screen background image
    NSString *launchImageName = [self launchImageNameForOrientation:self. interfaceOrientation];
    _backgroundImageView.image = [UIImage imageNamed:launchImageName];
    
    // Proceed to app after a couple of seconds
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate performSelector:@selector(closeLaunchScreenAndProceed) withObject:nil afterDelay:0.0f];
}

// Used from: http://stackoverflow.com/a/27797958/597292
- (NSString *)launchImageNameForOrientation:(UIInterfaceOrientation)orientation {
    
    CGSize viewSize = self.view.bounds.size;
    NSString *viewOrientation = @"Portrait";
    
    // Adjust for landscape mode
    if (UIDeviceOrientationIsLandscape(orientation)) {
        
        // Remove later when iOS 7 is not needed.
        if (SYSTEM_VERSION_GREATER_THAN(@"8.0")) {
            
            viewSize = CGSizeMake(viewSize.height, viewSize.width);
        }
        
        viewOrientation = @"Landscape";
    }
    
    // Extract loaded launch images
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    // Loop through loaded launch images
    for (NSDictionary *dict in imagesDict) {
        
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        // Return if launch image is found in loaded plist
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
            
            return dict[@"UILaunchImageName"];
    }
    
    return nil;
}

@end
