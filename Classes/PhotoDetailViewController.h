//
//  PhotoDetailViewController.h
//  decade
//
//  Created by Christine Yen on 11/18/11.
//  Copyright (c) 2011 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoDetailViewController : UIViewController {
    NSString *_photoName;
    IBOutlet UIImageView *imageView;
}

@property (assign) NSString *photoName;
@end
