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
	UITabBarController *tabBarController;
	UINavigationController *navController1;
	UINavigationController *navController2;
    FlickrFetcher *fetcher;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (NSURL *)applicationDocumentsDirectory;

@end

