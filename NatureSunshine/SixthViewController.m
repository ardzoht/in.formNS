//
//  SixthViewController.m
//  NatureSunshine
//
//  Created by moviles on 3/10/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "SixthViewController.h"
#import "LoginViewController.h"
#import "graphsViewController.h"
#import <Parse/Parse.h>

@interface SixthViewController ()

@end

@implementation SixthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mySegmentedControl.selectedSegmentIndex = 0;
     dataTxtField.delegate = self;
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

- (IBAction)segmentedValue:(id)sender {
    if(mySegmentedControl.selectedSegmentIndex == 0){
        messageForEachSegmented.text = @"How much water did you drink?";
        optionLabel.text = @"Ounces:";
        dataTxtField.text = NULL;
        dataTxtField.placeholder = @"Oz.";
        confirmationLabel.text = @"Fill the space above, then tap Send";
    }
    
    else if(mySegmentedControl.selectedSegmentIndex == 1){
        messageForEachSegmented.text = @"How much calories did you consume?";
        optionLabel.text = @"Calories:";
        dataTxtField.text = NULL;
        dataTxtField.placeholder = @"Cals.";
        confirmationLabel.text = @"Fill the space above, then tap Send";
    }
    
    else if(mySegmentedControl.selectedSegmentIndex == 2){
        messageForEachSegmented.text = @"What's your actual weight?";
        optionLabel.text = @"Pounds:";
        dataTxtField.text = NULL;
        dataTxtField.placeholder = @"Lbs.";
        confirmationLabel.text = @"Fill the space above, then tap Send";
    }

}

- (IBAction)sendTrackerData:(id)sender {
    NSString *theData;
    
        //For the first segmented index
    if(mySegmentedControl.selectedSegmentIndex == 0){
        
      if(![dataTxtField.text isEqual:@""]){
        theData = dataTxtField.text;
        NSLog(@"%@", dataTxtField.text);
        confirmationLabel.text = [NSString stringWithFormat:@"You info has been uploaded!"];
        
        PFUser *currentUser = [PFUser currentUser];
        PFObject *dataSent = [PFObject objectWithClassName:@"Water"];
    
        dataSent[@"nOunces"] = theData;
        dataSent[@"username"] = currentUser.username;
        
        [dataSent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Data uploaded");
            } else {
                UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Something went wrong..." message:@"There was an error while uploading your data. Please, try again." delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
                [myAlert show];
            }
        }];
        
        dataTxtField.text = NULL;
      }
        
        else{
            UIAlertView *noDataAlert = [[UIAlertView alloc] initWithTitle:@"Uh-oh..." message:@"You didn't write any data! Please, introduce your information." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [noDataAlert show];
        }
        
    }
    
        //For the second segmented index
    else if(mySegmentedControl.selectedSegmentIndex == 1){
        
      if(![dataTxtField.text isEqual:@""]){
        theData = dataTxtField.text;
        NSLog(@"%@", dataTxtField.text);
        confirmationLabel.text = [NSString stringWithFormat:@"You info has been uploaded!"];
        
        PFUser *currentUser = [PFUser currentUser];
        PFObject *dataSent = [PFObject objectWithClassName:@"Calories"];
        
        dataSent[@"nCalories"] = theData;
        dataSent[@"username"] = currentUser.username;
        
        [dataSent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Data uploaded");
            } else {
                UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Something went wrong..." message:@"There was an error while uploading your data. Please, try again." delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
                [myAlert show];
            }
        }];
        
        dataTxtField.text = NULL;
      }
        
            else{
                UIAlertView *noDataAlert = [[UIAlertView alloc] initWithTitle:@"Uh-oh..." message:@"You didn't write any data! Please, introduce your information." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [noDataAlert show];
           }
   }
    
        //For the third segmented index
    else if(mySegmentedControl.selectedSegmentIndex == 2){
       
      if(![dataTxtField.text isEqual:@""]){
        theData = dataTxtField.text;
        NSLog(@"%@", dataTxtField.text);
        confirmationLabel.text = [NSString stringWithFormat:@"You info has been uploaded!"];
        
        PFUser *currentUser = [PFUser currentUser];
        PFObject *dataSent = [PFObject objectWithClassName:@"Weight"];
        
        dataSent[@"nPounds"] = theData;
        dataSent[@"username"] = currentUser.username;
        
        [dataSent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Data uploaded");
            } else {
                UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Something went wrong..." message:@"There was an error while uploading your data. Please, try again." delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
                [myAlert show];
            }
        }];
        
        dataTxtField.text = NULL;
      }
        
        else{
            UIAlertView *noDataAlert = [[UIAlertView alloc] initWithTitle:@"Uh-oh..." message:@"You didn't write any data! Please, introduce your information." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [noDataAlert show];
        }
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == dataTxtField){
        [dataTxtField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (IBAction)showGraphs:(id)sender {
    
    graphsViewController *myGraphs = [[graphsViewController alloc] init];
    [self presentViewController:myGraphs animated:YES completion:nil];
}

- (IBAction)logout:(id)sender {
    [PFUser logOutInBackground];
}

@end
