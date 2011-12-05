//
//  PhotoMapViewController.h
//  decade
//
//  Created by Christine Yen on 12/1/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface PhotoMapViewController : UIViewController {
    IBOutlet MKMapView *mapView;
    NSString *foursquareOauthToken;
}

@end
