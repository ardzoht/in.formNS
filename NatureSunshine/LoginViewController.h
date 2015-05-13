//
//  LoginViewController.h
//  NatureSunshine
//
//  Created by alumno on 4/18/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController  : UIViewController<UIAlertViewDelegate, UITextFieldDelegate> {
    
}
@property (weak, nonatomic) IBOutlet UITextField *mailText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *forgot;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)login:(id)sender;
- (IBAction)forgotPW:(id)sender;
@end
