//
//  PhotoDetailViewController.h
//  decade
//
//  Created by Christine Yen on 11/18/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoDetailViewController : UIViewController<UIScrollViewDelegate> {
    Photo *_photo;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIImageView *imageView;

    IBOutlet UIView *textView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *personLabel;
}

@property (nonatomic, retain) Photo *photo;
@property (nonatomic, retain) UILabel *nameLabel, *personLabel;
@end
