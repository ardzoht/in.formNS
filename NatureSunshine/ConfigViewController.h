//
//  ConfigViewController.h
//  NatureSunshine
//
//  Created by alumno on 4/19/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *heightText;
@property (weak, nonatomic) IBOutlet UITextField *weightText;
@property (weak, nonatomic) IBOutlet UILabel *usernameDisplay;
@property (weak, nonatomic) IBOutlet UIImageView *profileView;

@property (weak, nonatomic) IBOutlet UIPickerView *coaches;
@property (weak, nonatomic) IBOutlet UIButton *send;

- (IBAction)setupUser:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *changePic;
- (IBAction)setPic:(id)sender;


@end
