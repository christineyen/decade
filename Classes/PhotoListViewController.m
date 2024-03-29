//
//  PhotoListViewController.m
//  decade
//
//  Created by Christine Yen on 11/18/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import "PhotoListViewController.h"
#import "PhotoDetailViewController.h"
#import "FlickrFetcher.h"


@implementation PhotoListViewController
@synthesize person=_person;
@synthesize endCell=_endCell;
@synthesize endCellCount=_endCellCount;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.835 green:0.839 blue:0.816 alpha:1.0];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (self.person != nil) {
        self.title = self.person.name;
    }
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
    [self.tableView reloadData];
}

- (void)refresh {
    [self stopLoading];
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

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];

    [self.navigationItem setHidesBackButton:editing animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.person.photos count] + 1;
}

- (UITableViewCell *)getTableViewCountCell:(UITableView *)tableView {
    static NSString *EndIdentifier = @"EndTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EndIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"EndUITableViewCell" owner:self options:nil];
        cell = self.endCell;
        self.endCell = nil;
    }
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.855 green:0.858 blue:0.832 alpha:1.0];
    self.endCellCount.text = [NSString stringWithFormat:@"%d", [self.person.photos count]];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isLastCell:indexPath]) { // the last item in the list
        return [self getTableViewCountCell:tableView];
    }
    
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    Photo *photo = [self.person.photosAsArray objectAtIndex:indexPath.row];

    cell.textLabel.text = photo.name;
    cell.imageView.image = [UIImage imageNamed:photo.path];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return ![self isLastCell:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Photo *photo = [self.person.photosAsArray objectAtIndex:indexPath.row];

        NSManagedObjectContext *context = [[FlickrFetcher sharedInstance] managedObjectContext];
        [context deleteObject:photo];
        [context save:nil];

        // Update UI
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        self.endCellCount.text = [NSString stringWithFormat:@"%d", [self.person.photos count]];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    PhotoDetailViewController *photoViewController = [[PhotoDetailViewController alloc] init];

    photoViewController.photo = [self.person.photosAsArray objectAtIndex:indexPath.row];
    photoViewController.wantsFullScreenLayout = YES;
    [self.navigationController pushViewController:photoViewController animated:YES];

    [photoViewController release];
}
                          
- (BOOL)isLastCell:(NSIndexPath *)indexPath {
    return indexPath.row == [self.person.photos count];
}
    
- (void)dealloc {
    [_person release];
    [super dealloc];
}

@end
