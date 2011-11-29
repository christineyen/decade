//
//  PhotoEditViewController.m
//  decade
//
//  Created by Christine Yen on 11/22/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import "PhotoEditViewController.h"

#define kTabBarHeight 50

@implementation PhotoEditViewController
@synthesize photo=_photo;
@synthesize nameTextField, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    NSLog(@"initWithNibName called for edit controller");
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
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
    scrollView.contentSize = CGSizeMake(320, 400);
    keyboardVisible = NO;

    imageView.image = [UIImage imageNamed:self.photo.path];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    nameTextField.text = self.photo.name;
    pathLabel.text = self.photo.path;
    personLabel.text = self.photo.person.name;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.photo release];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Listeners / Handlers

- (IBAction)clickedSave:(id)sender {
    [self.delegate photoEditViewDidSave:self];
}

- (IBAction)clickedCancel:(id)sender {
    [self.delegate photoEditViewDidCancel];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField = [textField retain];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    activeField = nil;
}

- (void)keyboardWasShown:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;

    // If the active text field is hidden by keyboard, scroll it so it's visible
    CGRect wholeFrame = scrollView.frame;
    wholeFrame.size.height -= kbSize.height;

    if (!CGRectContainsRect(wholeFrame, activeField.frame)) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y + kbSize.height);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

@end
