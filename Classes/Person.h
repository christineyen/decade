//
//  Person.h
//  decade
//
//  Created by Christine Yen on 11/21/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *photos;
@end

@interface Person (CoreDataGeneratedAccessors)

+ (NSString *)flickrRecentsName;
+ (Person *)flickrRecentsPerson;

- (BOOL)isFlickrUser;
- (void)fetchMorePhotos;
- (NSArray *)photosAsArray;
@end
