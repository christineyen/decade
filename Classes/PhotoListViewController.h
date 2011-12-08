//
//  PhotoListViewController.h
//  decade
//
//  Created by Christine Yen on 11/18/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
#import "Person.h"

@interface PhotoListViewController : PullRefreshTableViewController<UITableViewDelegate, UITableViewDataSource> {
    Person *_person;
}

@property (nonatomic, retain) Person *person;
@end
