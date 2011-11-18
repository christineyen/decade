//
//  PersonListViewController.m
//  decade
//
//  Created by Christine Yen on 11/16/11.
//  Copyright 2011 MIT. All rights reserved.
//

#import "PersonListViewController.h"
#import "PhotoListViewController.h"


@implementation PersonListViewController

@synthesize photoDb=_photoDb;

- (IBAction)pushViewController:(id) sender {
	PhotoListViewController *photoListController = [[PhotoListViewController alloc] init];
	photoListController.title = @"Photo List";

	[self.navigationController pushViewController:photoListController animated:YES];
	[photoListController release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"self.photoDb count: %d and _photoDb count: %d", [self.photoDb count], [_photoDb count]);
    return [self.photoDb count];
}

- (UITableViewCell *)tableView:(UITableView *)view cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [view dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    }
    cell.textLabel.text = @"TEXT HERE";
    return cell;
}
@end
