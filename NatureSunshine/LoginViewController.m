//
//  LoginViewController.m
//  NatureSunshine
//
//  Created by alumno on 4/18/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mailText.delegate = self;
    _passwordText.delegate = self;
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)login:(id)sender {
    
    [PFUser logInWithUsernameInBackground:_mailText.text password:_passwordText.text
                                    block: ^(PFUser *user, NSError *error)
     {
         if (user) {
             _mailText.text = @"";
             _passwordText.text = @"";
             NSString * storyboardName = @"Main";
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
             UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"homeVC"];
             [self presentViewController:vc animated:YES completion:nil];
             
         } else {
             NSString *errorString = [error userInfo][@"error"];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             [alert show];
         }
     }
     ];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == _passwordText) {
        [_passwordText resignFirstResponder];
    }
    else if(textField == _mailText) {
        [_passwordText becomeFirstResponder];
    }
    return YES;
}

- (IBAction)forgotPW:(id)sender {
    UIAlertView *forgotMessage = [[UIAlertView alloc] initWithTitle:@"Forgot Password?"
                                                            message:@"If you can't remember your password, we will send you an email to reset it."
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Confirm", nil];
    
    [forgotMessage setAlertViewStyle:UIAlertViewStylePlainTextInput];
    forgotMessage.tag = 100;
    [forgotMessage show];
}
-(BOOL) alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
    NSString *inputText = [[alertView textFieldAtIndex:0] text];
    if( [inputText length] >= 1 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *inputText = [[alertView textFieldAtIndex:0] text];
    if(alertView.tag == 100) {
        if (buttonIndex == 1) {
            [PFUser requestPasswordResetForEmailInBackground:inputText];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
        else {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
}

@end
