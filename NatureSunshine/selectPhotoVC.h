//
//  selectPhotoVC.h
//  NatureSunshine
//
//  Created by David Sáenz on 15/04/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface selectPhotoVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *mySelectImageView;
- (IBAction)selectMyImage:(id)sender;
- (IBAction)uploadImage:(id)sender;

@end
