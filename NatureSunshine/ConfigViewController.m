//
//  ConfigViewController.m
//  NatureSunshine
//
//  Created by alumno on 4/19/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "ConfigViewController.h"
#import <Parse/Parse.h>

@interface ConfigViewController () {
    NSMutableArray *arrayCoaches;
    NSString *coach;
    PFFile *imageFile;
}

@end

@implementation ConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coaches.delegate = self;
    self.coaches.dataSource = self;
    // Do any additional setup after loading the view.
    arrayCoaches  =[[NSMutableArray alloc]init];
    

    PFQuery *queryCoaches = [PFUser query];
    [queryCoaches whereKey:@"Coach" equalTo:[NSNumber numberWithInt:1]];
    [queryCoaches selectKeys:@[@"username"]];
    [queryCoaches findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                [arrayCoaches addObject:object[@"username"]];
                [self.coaches reloadAllComponents];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    self.usernameDisplay.text = [[PFUser currentUser] username];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return arrayCoaches.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return arrayCoaches[row];
}

// Capture the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    if(pickerView == self.coaches) {
        coach = [arrayCoaches objectAtIndex:row];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)setupUser:(id)sender {
    NSString *user = [[PFUser currentUser] username];
    PFObject *coachGroup = [PFObject objectWithClassName:@"CoachGroups"];
    coachGroup[@"user"] = user;
    coachGroup[@"coach"] = coach;
    NSData *data = UIImageJPEGRepresentation(self.profileView.image, 0.5f);
    
    imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    coachGroup[@"profilePic"] = imageFile;
    [coachGroup saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded) {
            //Object saved
            NSLog(@"Saved coach group successfully");
        } else {
            //There was an error
            NSLog(@"There was an error saving the object");
        }
    }];
    
}

- (IBAction)setPic:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.profileView.image = selectedImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
