//
//  PhotoMapViewController.h
//  decade
//
//  Created by Christine Yen on 12/1/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PhotoMapViewController : UIViewController<CLLocationManagerDelegate> {
    IBOutlet MKMapView *mapView;
    IBOutlet UIActivityIndicatorView *spinner;
    NSString *foursquareOauthToken;
    CLLocationManager *locationManager;
}

- (NSArray *)fetchAnnotationsForLat:(double)lat andLongitude:(double)lng;
- (void)setIsLoading:(BOOL)loading;


// load, immediately put up "loading" activity indicator
//   in bg thread, start the location service
//     when done, call back to main thread but don't remove the indicator
//     maybe try changing text of activity indicator to something more descriptive?
//   locationManager:didUpdateToLocation should already be set
//     when location is received, zoom into that location
//     do 4sq fetch with new lat/long
//     once data's fetched but before annotations are added, kill "loading" indicator
//     display annotations and zoom as necessary.

@end
