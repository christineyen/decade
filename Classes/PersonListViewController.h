//
//  PersonListViewController.h
//  decade
//
//  Created by Christine Yen on 11/16/11.
//  Copyright 2011 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PersonListViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tableView;
    NSArray *_photoDb;
}
@property (retain) NSArray *photoDb;

- (IBAction)pushViewController:(id) sender;

@end
