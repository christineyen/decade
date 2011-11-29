//
//  PhotoEditViewController.h
//  decade
//
//  Created by Christine Yen on 11/22/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "Person.h"

@protocol PhotoEditViewControllerDelegate;

@interface PhotoEditViewController : UIViewController<UITextFieldDelegate> {
    id <PhotoEditViewControllerDelegate> delegate;
    BOOL keyboardVisible;
    CGPoint offset;

    UITextField *activeField;

    Photo *_photo;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIImageView *imageView;
    IBOutlet UITextField *nameTextField;
    IBOutlet UILabel *pathLabel;
    IBOutlet UILabel *personLabel;
}
@property (nonatomic, retain) Photo *photo;
@property (nonatomic, assign) UITextField *nameTextField;
@property (nonatomic, assign) id <PhotoEditViewControllerDelegate> delegate;
@end


@protocol PhotoEditViewControllerDelegate

- (void)photoEditViewDidSave:(PhotoEditViewController *)editController;
- (void)photoEditViewDidCancel;

@end