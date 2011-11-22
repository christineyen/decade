//
//  PhotoDetailViewController.h
//  decade
//
//  Created by Christine Yen on 11/18/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoDetailViewController : UIViewController {
    Photo *_photo;
    IBOutlet UIImageView *imageView;
}

@property (nonatomic, retain) Photo *photo;
@end
