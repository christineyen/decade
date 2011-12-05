//
//  PhotoMapViewController.m
//  decade
//
//  Created by Christine Yen on 12/1/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import "PhotoMapViewController.h"
#import "SBJson.h"

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
    SBJsonParser *parser = [[SBJsonParser alloc] init];

    NSString *foursquareURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=37.7732,-122.4321&oauth_token=%@",
                               foursquareOauthToken];
    NSURL *url = [NSURL URLWithString:foursquareURL];
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSArray *items = [[[parser objectWithString:jsonString]
                       objectForKey:@"response"] objectForKey:@"venues"];
    CLLocationCoordinate2D venue;

    for (NSDictionary *venueAttrs in items) {
        NSDictionary *loc = [venueAttrs objectForKey:@"location"];
        venue.latitude = [[loc objectForKey:@"lat"] floatValue];
        venue.longitude = [[loc objectForKey:@"lng"] floatValue];

        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = venue;
        annotation.title = [venueAttrs objectForKey:@"name"];
        annotation.subtitle = [loc objectForKey:@"address"];

        [mapView addAnnotation:annotation];
        [annotation release];
    }

    MKCoordinateRegion region = mapView.region;
    region.span.latitudeDelta /= 10;
    region.span.longitudeDelta /= 10;
    region.center = venue;

    [mapView setRegion:region animated:YES];

    [parser release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
