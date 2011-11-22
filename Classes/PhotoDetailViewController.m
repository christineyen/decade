//
//  PhotoDetailViewController.m
//  decade
//
//  Created by Christine Yen on 11/18/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import "PhotoDetailViewController.h"
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

    self.title = self.photo.name;
    self.nameLabel.text = self.photo.path;
    self.personLabel.text = [NSString stringWithFormat:@"photo by %@", self.photo.person.name];

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(handleSingleTap:)];
    [imageView addGestureRecognizer:singleTap];
    [singleTap release];

    // Important settings - set userInteractionEnabled
    imageView.image = [UIImage imageNamed:self.photo.path];

    scrollView.maximumZoomScale = 10.0;
    scrollView.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
