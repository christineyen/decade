//
//  PhotoDetailViewController.m
//  decade
//
//  Created by Christine Yen on 11/18/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import "PhotoDetailViewController.h"

@implementation PhotoDetailViewController
@synthesize photo=_photo;

- (void)toggleNavigationBar:(BOOL)hidden {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];

    [self.navigationController setNavigationBarHidden:hidden animated:YES];
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
    imageView.image = [UIImage imageNamed:self.photo.path];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self toggleNavigationBar:!self.navigationController.navigationBarHidden];
}

@end
