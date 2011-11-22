//
//  PhotoListViewController.h
//  decade
//
//  Created by Christine Yen on 11/18/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrFetcher.h"

@interface PhotoListViewController : UITableViewController<UITableViewDelegate, NSFetchedResultsControllerDelegate, UITableViewDataSource> {
    NSFetchedResultsController *_fetchedResultsController;
}

@property (nonatomic, assign) FlickrFetcher *fetcher;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@end
