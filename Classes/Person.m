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


@implementation Person

@dynamic name;
@dynamic photos;

+ (Person *)fakeRecentsPerson {
    FlickrFetcher *fetcher = [FlickrFetcher sharedInstance];
    NSArray *photos = [fetcher fetchManagedObjectsForEntity:@"Photo" withPredicate:nil];

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person"
                                              inManagedObjectContext:[fetcher managedObjectContext]];

    Person *person = [[Person alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    person.name = @"Recents";

    [person addPhotos:[NSSet setWithArray:photos]];
    return [person autorelease];
}

- (NSArray *)photosAsArray {
    NSSortDescriptor *desc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [[self.photos allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:desc]];
}
@end
