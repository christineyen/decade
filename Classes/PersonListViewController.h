//
//  PersonListViewController.h
//  decade
//
//  Created by Christine Yen on 11/16/11.
//  Copyright 2011 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PersonListViewController : UITableViewController<UITableViewDelegate, NSFetchedResultsControllerDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tableView;

    NSFetchedResultsController *_fetchedResultsController;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (IBAction)pushViewController:(id) sender;

@end
