//
//  selectPhotoVC.m
//  NatureSunshine
//
//  Created by David Sáenz on 15/04/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "selectPhotoVC.h"
#import <Parse/Parse.h>
@interface selectPhotoVC () {
    NSString *coachString;
    PFFile *imageFile;
    UIImage *image;
}

@end

@implementation selectPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFQuery *coach = [PFQuery queryWithClassName:@"CoachGroups"];
    [coach whereKey:@"user" equalTo:[PFUser currentUser].username];
    [coach selectKeys:@[@"coach"]];
    PFObject *coachObject = [coach getFirstObject];
    coachString = coachObject[@"coach"];
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

- (IBAction)selectMyImage:(id)sender {
    UIImagePickerController *myPicker = [[UIImagePickerController alloc] init];
    myPicker.delegate = self;
    myPicker.allowsEditing = YES;
    myPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:myPicker animated:YES completion:NULL];
}

- (IBAction)uploadImage:(id)sender {
    NSString *user = [[PFUser currentUser] username];
    PFObject *photo = [PFObject objectWithClassName:@"UserPhotos"];
    photo[@"user"] = user;
    photo[@"coach"] = coachString;
    NSData *data = UIImageJPEGRepresentation(image, 0.5f);
    
    imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    photo[@"photo"] = imageFile;
    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded) {
            //Object saved
            NSLog(@"Saved coach group successfully");
        } else {
            //There was an error
            NSLog(@"There was an error saving the object");
            
        }
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    UIImage *mySelectedImage = info[UIImagePickerControllerEditedImage];
    self.mySelectImageView.image = mySelectedImage;
    image = mySelectedImage;

    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
