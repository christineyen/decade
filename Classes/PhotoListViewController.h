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
    UITableViewCell *endCell;
    UILabel *endCellLabel;
}

@property (nonatomic, retain) Person *person;
@property (nonatomic, assign) UILabel *endCellLabel;

- (BOOL)isLastCell:(NSIndexPath *)indexPath;
@end
