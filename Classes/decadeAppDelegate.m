//
//  decadeAppDelegate.m
//  decade
//
//  Created by Christine Yen on 11/16/11.
//  Copyright 2011 MIT. All rights reserved.
//

#import "decadeAppDelegate.h"
#import "PersonListViewController.h"
#import "PhotoListViewController.h"
#import "FlickrFetcher.h"
#import "Photo.h"
#import "Person.h"

@implementation decadeAppDelegate

@synthesize window;

- (int)loadDatabaseWithDefaults {
    fetcher = [FlickrFetcher sharedInstance];
    if (![fetcher databaseExists]) {
        NSString *thePath = [[NSBundle mainBundle] pathForResource:@"Photos" ofType:@"plist"];
        NSArray *db = [[NSArray alloc] initWithContentsOfFile:thePath];

        NSMutableDictionary *namePersonDict = [[NSMutableDictionary alloc] init];
        Person *person;
        NSString *personName;

        NSManagedObjectContext *context = [fetcher managedObjectContext];

        for (NSDictionary *photo in db) {
            Photo *photoObj = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
            photoObj.name = [photo objectForKey:@"name"];
            photoObj.path = [photo objectForKey:@"path"];
            personName = [photo objectForKey:@"user"];

            person = [namePersonDict objectForKey:personName];
            if (person == nil) {
                person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
                person.name = personName;

                [namePersonDict setObject:person forKey:personName];
            }
            photoObj.person = person;
        }

        if (![context save:NULL]) {
            NSLog(@"FAILED TO SAVE!!");
        }

        [namePersonDict release];
        return [[db autorelease] count];
    }
    return 0;
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    int loaded = [self loadDatabaseWithDefaults];
    NSLog(@"Read and loaded %d rows from the .plist", loaded);

	tabBarController = [[UITabBarController alloc] init];

    // Set up Contacts tab
	PersonListViewController *personListController = [[PersonListViewController alloc] initWithStyle:UITableViewStylePlain];
    personListController.fetchedResultsController = [fetcher fetchedResultsControllerForEntity:@"Person"
                                                                                 withPredicate:nil];
    personListController.fetcher = fetcher;
	personListController.title = @"People";

	navController1 = [[UINavigationController alloc] initWithRootViewController:personListController];
    navController1.navigationBar.translucent = YES;


    // Set up Recents tab
    PhotoListViewController *fakeRecentsController = [[PhotoListViewController alloc] init];

    fakeRecentsController.person = [Person fakeRecentsPerson];
    fakeRecentsController.title = @"Recents";

	navController2 = [[UINavigationController alloc] initWithRootViewController:fakeRecentsController];


    // Override point for customization after application launch.
	tabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2, nil];

	UITabBarItem *item1 = [[UITabBarItem alloc]
						  initWithTabBarSystemItem:UITabBarSystemItemContacts
						  tag:0];
	navController1.tabBarItem = item1;
	[item1 release];

	UITabBarItem *item2 = [[UITabBarItem alloc]
						   initWithTabBarSystemItem:UITabBarSystemItemRecents
						   tag:0];
	navController2.tabBarItem = item2;
	[item2 release];
	
	[self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
	
    [fakeRecentsController release];
	[personListController release];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
}    


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [navController2 release];
    [navController1 release];
    [tabBarController release];

    [window release];
    [super dealloc];
}


@end

