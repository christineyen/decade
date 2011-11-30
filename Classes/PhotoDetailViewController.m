//
//  PhotoDetailViewController.m
//  decade
//
//  Created by Christine Yen on 11/18/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "PhotoEditViewController.h"
#import "Person.h"

@implementation PhotoDetailViewController
@synthesize photo=_photo;
@synthesize nameLabel, personLabel;

- (void)toggleNavigationBar:(BOOL)hidden {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];

    [self.navigationController setNavigationBarHidden:hidden animated:YES];
    [UIView commitAnimations];
}

- (void)toggleTextView:(BOOL)hidden {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];

    int alpha = (hidden == YES) ? 0 : 100;
    [textView setAlpha:alpha];
    [UIView commitAnimations];
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

    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.nameLabel.text = self.photo.path;
    self.personLabel.text = [NSString stringWithFormat:@"photo by %@", self.photo.person.name];

    // Fetch the image if necessary
    UIImage *uiImg = [self.photo getUIImage];
    if (uiImg != nil) {
        imageView.image = uiImg;
    } else if (self.photo.url != nil) {
        [spinner startAnimating];
        spinner.hidden = NO;
        textView.hidden = YES;

        [NSThread detachNewThreadSelector:@selector(imageFetchInBackground:)
                                 toTarget:self
                               withObject:self.photo.url];
    }

    // Handle gestures
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(handleSingleTap:)];
    [imageView addGestureRecognizer:singleTap];
    [singleTap release];

    // Important settings - set userInteractionEnabled
    scrollView.maximumZoomScale = 10.0;
    scrollView.delegate = self;
}

- (void)imageFetchInBackground:(NSString *)url {
    // We have to handle autorelease on our own inside NSThreads!
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    self.photo.data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];

    [self performSelectorOnMainThread:@selector(imageDoneFetching)
                           withObject:nil
                        waitUntilDone:YES];
    [pool release];
}

- (void)imageDoneFetching {
    imageView.image = [UIImage imageWithData:self.photo.data];
    textView.hidden = NO;
    spinner.hidden = YES;
    [spinner stopAnimating];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // Set in Appear rather than DidLoad bc it might have changed in the modal dialog
    self.title = self.photo.name;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // Override behavior (the default toggling of Edit -> Done
    // [super setEditing:editing animated:animated];

    if (editing) {
        PhotoEditViewController *editController = [[PhotoEditViewController alloc] init];

        editController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

        editController.photo = self.photo;
        editController.delegate = self;

        [self presentModalViewController:editController animated:animated];

        [editController release];
    }
}

- (void)photoEditViewDidSave:(PhotoEditViewController *)editController {
    self.photo.name = editController.nameTextField.text;
    [[self.photo managedObjectContext] save:nil];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)photoEditViewDidCancel {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
}

- (void)dealloc {
    [_photo release];
    [super dealloc];
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    BOOL hidden = !self.navigationController.navigationBarHidden;
    [self toggleNavigationBar:hidden];
    [self toggleTextView:hidden];
}

@end
