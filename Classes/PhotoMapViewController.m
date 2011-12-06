//
//  PhotoMapViewController.m
//  decade
//
//  Created by Christine Yen on 12/1/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import "PhotoMapViewController.h"
#import "SBJson.h"

// THIS IS A HACK to get around CoreLocation issues and iOS Simulator
// http://stackoverflow.com/questions/802156/testing-corelocation-on-iphone-simulator/3304378
#if TARGET_IPHONE_SIMULATOR
@interface CLLocationManager (Simulator)
@end

@implementation CLLocationManager (Simulator)

-(void)startMonitoringSignificantLocationChanges {
    [self startUpdatingLocation];
}
-(void)startUpdatingLocation {
    CLLocation *homeHome = [[[CLLocation alloc] initWithLatitude:37.256443
                                                       longitude:-122.017323] autorelease];
    [self.delegate locationManager:self
               didUpdateToLocation:homeHome
                      fromLocation:homeHome];
}

@end
#endif // TARGET_IPHONE_SIMULATOR


@implementation PhotoMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        foursquareOauthToken = @"44AIQ2GRI2FXJWKJBJI1S3S0V1MYKBEFYQLB2NCBDGU5D4II&v=20111204";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [spinner startAnimating];
    spinner.hidden = NO;
    
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;

    [locationManager startMonitoringSignificantLocationChanges];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [locationManager release];
    locationManager = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [mapView release];
    [spinner release];
    foursquareOauthToken = nil;
    [locationManager release];
    
    [super dealloc];
}

# pragma mark - Callbacks and helpers

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    NSArray *annos = [self fetchAnnotationsForLat:newLocation.coordinate.latitude
                                     andLongitude:newLocation.coordinate.longitude];
    
    // Hide Spinner
    spinner.hidden = YES;
    [spinner stopAnimating];
    
    // Manipulate map
    [mapView addAnnotations:annos];
    
    MKPointAnnotation *center = annos.lastObject;
    
    MKCoordinateRegion region = mapView.region;
    region.span.latitudeDelta /= 10;
    region.span.longitudeDelta /= 10;
    region.center = center.coordinate;
    
    [mapView setRegion:region animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"location manager errored out!");
}

- (NSArray *)fetchAnnotationsForLat:(double)lat andLongitude:(double)lng {
    NSLog(@"fetching annotations for lat: %f, lng: %f", lat, lng);
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSString *foursquareURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%f,%f&oauth_token=%@",
                               lat, lng, foursquareOauthToken];
    NSURL *url = [NSURL URLWithString:foursquareURL];
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSArray *items = [[[parser objectWithString:jsonString]
                       objectForKey:@"response"] objectForKey:@"venues"];
    NSMutableArray *annos = [[NSMutableArray alloc] init];
    
    // Populate map and zoom as necessary
    for (NSDictionary *venueAttrs in items) {
        NSDictionary *loc = [venueAttrs objectForKey:@"location"];
        CLLocationCoordinate2D venue = {
            [[loc objectForKey:@"lat"] floatValue], [[loc objectForKey:@"lng"] floatValue]
        };
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = venue;
        annotation.title = [venueAttrs objectForKey:@"name"];
        annotation.subtitle = [loc objectForKey:@"address"];
        
        [annos addObject:annotation];
        
        [annotation release];
    }
    
    [parser release];
    return [annos autorelease];
}

@end
