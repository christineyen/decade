//
//  Photo.h
//  decade
//
//  Created by Christine Yen on 11/21/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) Person *person;

- (UIImage *)getUIImage;
@end
