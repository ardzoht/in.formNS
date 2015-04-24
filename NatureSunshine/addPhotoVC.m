//
//  addPhotoVC.m
//  NatureSunshine
//
//  Created by David Sáenz on 15/04/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "addPhotoVC.h"
#import <Parse/Parse.h>
@interface addPhotoVC () {
    NSString *coachString;
    PFFile *imageFile;
    UIImage *image;
    
}

@end

@implementation addPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertView *anAlert = [[UIAlertView alloc] initWithTitle:@"Important" message:@"Your device does not count with camera." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [anAlert show];
    }
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)takeAPhoto:(id)sender {
   
    UIImagePickerController *myPicker = [[UIImagePickerController alloc] init];
    myPicker.delegate = self;
    myPicker.allowsEditing = YES;
    myPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
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
    UIImage *myImage = info[UIImagePickerControllerEditedImage];
    self.myImageView.image = myImage;
    image = myImage;
    UIImageWriteToSavedPhotosAlbum(myImage, nil, nil, nil);
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
