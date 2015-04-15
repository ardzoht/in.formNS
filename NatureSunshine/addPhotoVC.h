//
//  addPhotoVC.h
//  NatureSunshine
//
//  Created by David Sáenz on 15/04/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addPhotoVC : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

- (IBAction)takeAPhoto:(id)sender;

- (IBAction)selectAPhoto:(id)sender;

@end
