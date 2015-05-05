//
//  SignViewController.h
//  NatureSunshine
//
//  Created by alumno on 4/18/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *mailText;
@property (weak, nonatomic) IBOutlet UITextField *passText;

@property (weak, nonatomic) IBOutlet UIButton *signButton;
@property (weak, nonatomic) IBOutlet UITextField *confirmText;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *type;
- (IBAction)loginFacebook:(id)sender;


- (IBAction)doneSignUp:(id)sender;


@end
