//
//  PersonListViewController.m
//  decade
//
//  Created by Christine Yen on 11/16/11.
//  Copyright 2011 MIT. All rights reserved.
//

#import "PersonListViewController.h"
#import "PhotoListViewController.h"
#import "FlickrFetcher.h"
#import "Person.h"
#import "Photo.h"


@implementation PersonListViewController
@synthesize fetchedResultsController=_fetchedResultsController;
@synthesize fetcher;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);
    }
    self.fetchedResultsController.delegate = self;

    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)view cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [view dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:MyIdentifier]
                autorelease];
    }

    Person *person = [self.fetchedResultsController objectAtIndexPath:indexPath];
    Photo *photo = [person.photos anyObject];

    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Photos", [person.photos count]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:photo.path];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;

    return cell;
}

- (void)tableView:(UITableView *)view didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [view deselectRowAtIndexPath:indexPath animated:NO];

    PhotoListViewController *photoViewController = [[PhotoListViewController alloc] init];
    photoViewController.person = [self.fetchedResultsController objectAtIndexPath:indexPath];

    [self.navigationController pushViewController:photoViewController animated:YES];
    [photoViewController release];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

- (void)dealloc {
    [_fetchedResultsController release];
    [super dealloc];
}
@end
