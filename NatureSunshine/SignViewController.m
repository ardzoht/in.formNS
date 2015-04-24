//
//  SignViewController.m
//  NatureSunshine
//
//  Created by alumno on 4/18/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "SignViewController.h"
#import <Parse/Parse.h>

@interface SignViewController ()

@end

@implementation SignViewController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.contentSize = CGSizeMake(1024, 768);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)doneSignUp:(id)sender {
    
    PFUser *user = [PFUser user];
    
    user.username = _userText.text;
    
    if([_passText.text isEqualToString:_confirmText.text]) {
        user.password = _passText.text;
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Password confirmation declined. Check it again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    user.email = _mailText.text;
    

    
    if (_type.selectedSegmentIndex == 0) {
        NSNumber *isCoach = [NSNumber numberWithInt:0];
        [user setObject:isCoach forKey: @"Coach"];

    }
    else {
        NSNumber *isCoach = [NSNumber numberWithInt:1];
        [user setObject:isCoach forKey: @"Coach"];
    }
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if ( !error ) {
            NSString * storyboardName = @"Main";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
            
            if(_type.selectedSegmentIndex == 0) {
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"configVC"];
            [self presentViewController:vc animated:YES completion:nil];
            }
            else {
                NSString *user = [[PFUser currentUser] username];
                PFObject *coachGroup = [PFObject objectWithClassName:@"CoachGroups"];
                coachGroup[@"user"] = user;
                coachGroup[@"coach"] = user;
                [coachGroup saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if(succeeded) {
                        //Object saved
                        NSLog(@"Saved coach group successfully");
                    } else {
                        //There was an error
                        NSLog(@"There was an error saving the object");
                    }
                }];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"homeVC"];
            [self presentViewController:vc animated:YES completion:nil];
            }
        } else {
            NSString *errorStr = [error userInfo][@"error"];
            NSLog(@"Error: %@", errorStr);
        }
    }];
    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == _confirmText) {
        [_confirmText resignFirstResponder];
    }
    else if(textField == _userText) {
        [_mailText becomeFirstResponder];
    }
    else if(textField == _mailText) {
        [_passText becomeFirstResponder];
    }
    else if(textField == _passText) {
        [_confirmText becomeFirstResponder];
    }
    return YES;
}

- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}
- (void)keyboardWasShown:(NSNotification *)notification {
    
    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGPoint buttonOrigin = self.signButton.frame.origin;
    
    CGFloat buttonHeight = self.signButton.frame.size.height;
    
    CGRect visibleRect = self.view.frame;
    
    visibleRect.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
        
        CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);
        
        [self.scrollView setContentOffset:scrollPoint animated:YES];
        
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}



@end
