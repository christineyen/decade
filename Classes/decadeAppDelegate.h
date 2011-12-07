//
//  decadeAppDelegate.h
//  decade
//
//  Created by Christine Yen on 11/16/11.
//  Copyright 2011 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FlickrFetcher.h"

@interface decadeAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *peopleNavController;
    UINavigationController *recentsNavController;
    UIViewController *mapController;
    
	UITabBarController *tabBarController;
    FlickrFetcher *fetcher;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (NSURL *)applicationDocumentsDirectory;
- (void)setNetworkActivityIndicatorVisible:(BOOL)setVisible;

@end

