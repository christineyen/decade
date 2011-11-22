//
//  PersonListViewController.h
//  decade
//
//  Created by Christine Yen on 11/16/11.
//  Copyright 2011 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrFetcher.h"


@interface PersonListViewController : UITableViewController<UITableViewDelegate, NSFetchedResultsControllerDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tableView;

    NSFetchedResultsController *_fetchedResultsController;
}

@property (nonatomic, assign) FlickrFetcher *fetcher;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
