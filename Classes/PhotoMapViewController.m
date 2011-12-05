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

    NSString *foursquareURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=37.7732,-122.4321&oauth_token=%@", foursquareOauthToken];
    NSURL *url = [NSURL URLWithString:foursquareURL];
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSArray *items = [[[parser objectWithString:jsonString] objectForKey:@"response"] objectForKey:@"venues"];

    for (NSDictionary *venueAttrs in items) {
        float lat = [[[venueAttrs objectForKey:@"location"] objectForKey:@"lat"] floatValue];
        float lng = [[[venueAttrs objectForKey:@"location"] objectForKey:@"lng"] floatValue];
        NSLog(@"lat: %f, lng: %f", lat, lng);
    }


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
