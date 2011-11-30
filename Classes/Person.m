//
//  Person.m
//  decade
//
//  Created by Christine Yen on 11/21/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import "Person.h"
#import "Photo.h"
#import "FlickrFetcher.h"
#import "SBJson.h"

#define kMaxInterestingPhotos 50


@implementation Person

@dynamic name;
@dynamic photos;

+ (NSString *)flickrRecentsName {
    return @"Flickr Users";
}

+ (Person *)flickrRecentsPerson {
    FlickrFetcher *fetcher = [FlickrFetcher sharedInstance];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name = %@", [self flickrRecentsName]];
    NSArray *flickrResults = [fetcher fetchManagedObjectsForEntity:@"Person" withPredicate:pred];
    
    // Set up root Person
    Person *person;
    if ([flickrResults count] > 0) {
        person = [[flickrResults objectAtIndex:0] retain];
    } else {
        NSManagedObjectContext *context = [fetcher managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person"
                                                  inManagedObjectContext:context];
        person = [[Person alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        person.name = [self flickrRecentsName];
    }
    
    // Fetch items from Flickr, within reason
    if ([person.photos count] < 50) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSManagedObjectContext *context = [fetcher managedObjectContext];
        NSString *flickrInterestingUrl = @"http://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1";

        // TODO: actually handle errors more gracefully, somewhere
        NSURL *url = [NSURL URLWithString:flickrInterestingUrl];
        NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSArray *items = [[parser objectWithString:jsonString] objectForKey:@"items"];
        Photo *photo;
        NSString *flickrUrl;

        for (NSDictionary *photoAttrs in items) {
            photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo"
                                                         inManagedObjectContext:context];
            photo.name = [photoAttrs objectForKey:@"title"];
            photo.person = person;

            flickrUrl = [[photoAttrs objectForKey:@"media"] objectForKey:@"m"];
            photo.url = [flickrUrl stringByReplacingOccurrencesOfString:@"_m.jpg" withString:@"_z.jpg"];
        }
        [parser release];

        [context save:nil];
    }
    return [person autorelease];
}

- (NSArray *)photosAsArray {
    NSSortDescriptor *desc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [[self.photos allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:desc]];
}
@end
