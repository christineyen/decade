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

@interface PhotoEditViewController : UIViewController<UITextFieldDelegate> {
    BOOL keyboardVisible;
    CGPoint offset;

    UITextField *activeField;

    Photo *_photo;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIImageView *imageView;
    IBOutlet UITextField *nameTextField;
    IBOutlet UILabel *pathLabel;
    IBOutlet UILabel *personLabel;
}
@property (nonatomic, retain) Photo *photo;

- (IBAction)clickedSave:(id)sender;
- (IBAction)clickedCancel:(id)sender;
@end
