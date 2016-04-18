//
//  MapsViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 18/04/16.
//  Copyright © 2016 Gytenis Mikulėnas 
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
//

#import "MapsViewController.h"
#import <AddressBookUI/AddressBookUI.h>

#define kMapPlaceCellIdentifier @"MapPlaceCellIdentifier"

@interface MapsViewController () {
    
    NSTimer *_searchTimer;
    UIActivityIndicatorView *_activityView;
    CLLocationManager *_locationManager;
}

@property (atomic, strong) NSMutableArray *reverseGeocodedLocationsInProgress;

@end

@implementation MapsViewController

- (void)dealloc {
    
    [self discardSearch];
    [_locationManager stopUpdatingLocation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self prepareUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.analyticsManager logScreen:kAnalyticsManagerScreenMap];
}

#pragma mark - Protected -

- (void)commonInit {
    
    [super commonInit];
    
    _geocoder = [[CLGeocoder alloc] init];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    _locationManager.delegate = self;
    
    _reverseGeocodedLocationsInProgress = [[NSMutableArray alloc] init];
}

- (void)initUI {
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kMapPlaceCellIdentifier];
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.tintColor = [UIColor blackColor];
    
    [_tableView addSubview:_activityView];
    
    [_activityView viewAddWidth:20.0f];
    [_activityView viewAddHeight:20.0f];
    [_activityView viewAddTopSpace:5.0f containerView:_tableView];
    [_activityView viewAddCenterHorizontalInsideContainerView:_tableView];
    
    _searchBar.returnKeyType = UIReturnKeyDone;
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        
        [self.messageBarManager showAlertOkWithTitle:nil description:GMLocalizedString(kMapViewControllerLocationServicesDisabledMessage) okTitle:GMLocalizedString(kOkKey) okCallback:nil];
        
    } else {
        
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            
            [_locationManager requestWhenInUseAuthorization];
        }
        
        [_locationManager startUpdatingLocation];
    }
}

- (void)prepareUI {
    
    [super prepareUI];
}

- (void)renderUI {
    
    [super renderUI];
    
    // ...
}

- (void)loadModel {
    
    [super loadModel];
    
    // ...
}

#pragma mark UISearchBarDelegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [self discardSearch];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self discardSearch];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    // stop scheduled timer for previous text search that was not performed
    [self stopTimer];
    
    if (searchText.length > 0) {
        
        NSDictionary *paramDic = @{@"searchText":searchText};
        
        _searchTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f
                                                        target:self
                                                      selector:@selector(performSearchWithinTimer:)
                                                      userInfo:paramDic
                                                       repeats:NO];
    } else {
        
        _model.places = nil;
        [_tableView reloadData];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _model.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMapPlaceCellIdentifier];
    
    MKMapItem *place = nil;
    
    // Double protection againts crash in case place is missing
    if (_model.places.count > indexPath.row) {
        
        place = _model.places[indexPath.row];
    }
    
    cell.textLabel.text = [self addressFromPlacemark:place.placemark];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MKMapItem *place = nil;
    
    // Double protection againts crash in case place is missing
    if (_model.places.count > indexPath.row) {
        
        place = _model.places[indexPath.row];
    }
    
    [self centerMapToLocation:place.placemark.location];
    
    [_searchBar resignFirstResponder];
}

#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    CLLocationCoordinate2D centerCoordinate = self.mapView.centerCoordinate;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    
    [self updateSearchBarWithAddressForLocation:location];
}

#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    if (newLocation.horizontalAccuracy <= kCLLocationAccuracyThreeKilometers) {
        
        [_locationManager stopUpdatingLocation];
        _locationManager.delegate = nil;
        [self centerMapToLocation:newLocation];
    }
}

#pragma mark - Private -

- (NSString *)addressFromPlacemark:(MKPlacemark *)placemark {
    
    // Converts placemark dictionary into human readable nice formatted address
    NSString *address = ABCreateStringWithAddressDictionary(placemark.addressDictionary, NO);
    
    /*if (!address.length) {
     
     address = [placemark.addressDictionary objectForKey:@"Name"];
     }*/
    
    address = [address stringByReplacingOccurrencesOfString:@"\n" withString:@", "];
    
    return address;
}

- (void)centerMapToLocation:(CLLocation *)location {
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    region.span = span;
    region.center = location.coordinate;
    
    [_mapView setRegion:region animated:YES];
}

- (void)discardSearch {
    
    [self stopTimer];
    _model.places = nil;
    _tableView.hidden = YES;
}

- (void)performSearchWithinTimer:(NSTimer *)timer {
    
    NSDictionary *dic = [timer userInfo];
    NSString *searchText = [dic objectForKey:@"searchText"];
    if (searchText) {
        
        _tableView.hidden = NO;
        _model.places = nil;
        [_tableView reloadData];
        
        __weak typeof (self) weakSelf = self;
        
        [weakSelf showProgressView];
        
        MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
        request.region = _mapView.region;;
        request.naturalLanguageQuery = searchText;
        MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:request];
        [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
            
            [weakSelf hideProgressView];
            
            weakSelf.model.places = response.mapItems;
            [weakSelf.tableView reloadData];
        }];
    }
}

- (void)stopTimer {
    
    //if ([_searchTimer isKindOfClass:[NSTimer class]]){
    if (_searchTimer) {
        
        [_searchTimer invalidate];
        _searchTimer = nil;
    }
}

- (void)showProgressView {
    
    [_activityView startAnimating];
}

- (void)hideProgressView {
    
    [_activityView stopAnimating];
}

- (void)updateSearchBarWithAddressForLocation:(CLLocation *)location {
    
    __weak typeof (self) weakSelf = self;
    
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error){
            
            DDLogWarn(@"%@", [error localizedDescription]);
            
        } else {
            
            CLPlacemark *placemark = [placemarks lastObject];
            weakSelf.searchBar.text = [self addressFromPlacemark:(MKPlacemark *)placemark];
        }
    }];
}

@end

