//
//  SixthViewController.m
//  NatureSunshine
//
//  Created by moviles on 3/10/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "SixthViewController.h"
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
        confirmedData.text = NULL;
    }
    
    else if(mySegmentedControl.selectedSegmentIndex == 1){
        messageForEachSegmented.text = @"How much calories did you consume?";
        optionLabel.text = @"Calories:";
        dataTxtField.text = NULL;
        dataTxtField.placeholder = @"Cals.";
        confirmationLabel.text = @"Fill the space above, then tap Send";
        confirmedData.text = NULL;
    }
    
    else if(mySegmentedControl.selectedSegmentIndex == 2){
        messageForEachSegmented.text = @"What's your actual weight?";
        optionLabel.text = @"Pounds:";
        dataTxtField.text = NULL;
        dataTxtField.placeholder = @"Lbs.";
        confirmationLabel.text = @"Fill the space above, then tap Send";
        confirmedData.text = NULL;
    }

}

- (IBAction)sendTrackerData:(id)sender {
    double theData;
    
    if(mySegmentedControl.selectedSegmentIndex == 0){
        theData = [dataTxtField.text doubleValue];
        NSLog(@"%@", dataTxtField.text);
        NSLog(@"%f", theData);
        confirmationLabel.text = [NSString stringWithFormat:@"You info has been uploaded!"];
        confirmedData.text = [NSString stringWithFormat:@"%.2f %s", theData, "Oz."];
        
        NSNumber *myData = [NSNumber numberWithDouble:theData];
        
        PFUser *currentUser = [PFUser currentUser];
        PFObject *dataSent = [PFObject objectWithClassName:@"Water"];
    
        dataSent[@"nOunces"] = myData;
        dataSent[@"username"] = currentUser.username;
        
        [dataSent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Data uploaded");
            } else {
                UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Something went wrong..." message:@"Ther was an error while uploading your data. Please, try again." delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
                [myAlert show];
            }
        }];
        
    }
    
    else if(mySegmentedControl.selectedSegmentIndex == 1){
        theData = [dataTxtField.text doubleValue];
        NSLog(@"%@", dataTxtField.text);
        NSLog(@"%f", theData);
        confirmationLabel.text = [NSString stringWithFormat:@"You info has been uploaded!"];
        confirmedData.text = [NSString stringWithFormat:@"%.2f %s", theData, "Cals."];
        
        NSNumber *myData = [NSNumber numberWithDouble:theData];
        
        PFUser *currentUser = [PFUser currentUser];
        PFObject *dataSent = [PFObject objectWithClassName:@"Calories"];
        
        dataSent[@"nCalories"] = myData;
        dataSent[@"username"] = currentUser.username;
        
        [dataSent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Data uploaded");
            } else {
                UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Something went wrong..." message:@"Ther was an error while uploading your data. Please, try again." delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
                [myAlert show];
            }
        }];
    }
    
    else if(mySegmentedControl.selectedSegmentIndex == 2){
       theData = [dataTxtField.text doubleValue];
        NSLog(@"%@", dataTxtField.text);
        NSLog(@"%f", theData);
        confirmationLabel.text = [NSString stringWithFormat:@"You info has been uploaded!:"];
        confirmedData.text = [NSString stringWithFormat:@"%.2f %s", theData, "Lbs."];
        
        NSNumber *myData = [NSNumber numberWithDouble:theData];
        
        PFUser *currentUser = [PFUser currentUser];
        PFObject *dataSent = [PFObject objectWithClassName:@"Weight"];
        
        dataSent[@"nPounds"] = myData;
        dataSent[@"username"] = currentUser.username;
        
        [dataSent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Data uploaded");
            } else {
                UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Something went wrong..." message:@"Ther was an error while uploading your data. Please, try again." delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
                [myAlert show];
            }
        }];
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

@end
