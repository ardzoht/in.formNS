//
//  FirstViewController.m
//  NatureSunshine
//
//  Created by moviles on 3/10/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "FirstViewController.h"
#import "PostCell.h"
#import <Parse/Parse.h>
@interface FirstViewController () {
    NSNumber *isCoachNumber;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PFQuery *coach = [PFQuery queryWithClassName:@"CoachGroups"];
    [coach whereKey:@"user" equalTo:[PFUser currentUser].username];
    [coach selectKeys:@[@"coach"]];
    PFObject *coachObject = [coach getFirstObject];
    coachString = coachObject[@"coach"];
    
    PFQuery *isCoach = [PFUser query];
    [isCoach whereKey:@"username" equalTo:[PFUser currentUser].username];
    [isCoach selectKeys:@[@"Coach"]];
    PFObject *isCoachObject = [isCoach getFirstObject];
    isCoachNumber = isCoachObject[@"Coach"];
    
    PFQuery *group = [PFQuery queryWithClassName:@"Posts"];
    [group whereKey:@"coach" equalTo:coachString];
    [group selectKeys:@[@"post", @"username", @"isCoach"]];
    [group orderByDescending:@"createdAt"];
    [group findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d posts.", objects.count);
            // Do something with the found objects
            posts = objects;
            [_wallView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.wallView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [posts count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell"];
    
    if(posts[indexPath.row][@"isCoach"] == [NSNumber numberWithInt:1]) {
        type = @"Coach";
    }
    else {
        type = @"Member";
    }
    cell.post.lineBreakMode = NSLineBreakByWordWrapping;
    cell.post.numberOfLines = 0;
    cell.post.text = posts[indexPath.row][@"post"];
    cell.name.text = posts[indexPath.row][@"username"];
    cell.type.text = type;
    return cell;
}

-(void) updateData {
    PFQuery *coach = [PFQuery queryWithClassName:@"CoachGroups"];
    [coach whereKey:@"user" equalTo:[PFUser currentUser].username];
    [coach selectKeys:@[@"coach"]];
    PFObject *coachObject = [coach getFirstObject];
    coachString = coachObject[@"coach"];
    
    PFQuery *isCoach = [PFUser query];
    [isCoach whereKey:@"username" equalTo:[PFUser currentUser].username];
    [isCoach selectKeys:@[@"Coach"]];
    PFObject *isCoachObject = [isCoach getFirstObject];
    isCoachNumber = isCoachObject[@"Coach"];
    
    PFQuery *group = [PFQuery queryWithClassName:@"Posts"];
    [group whereKey:@"coach" equalTo:coachString];
    [group selectKeys:@[@"post", @"username", @"isCoach"]];
    [group orderByDescending:@"createdAt"];
    [group findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d posts.", objects.count);
            // Do something with the found objects
            posts = objects;
            [_wallView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.sender) {
        [textField resignFirstResponder];
        if ([textField.text length] > 0 || textField.text != nil || [textField.text isEqual:@""] == FALSE) {
            PFObject *post = [PFObject objectWithClassName:@"Posts"];
            post[@"post"] = textField.text;
            post[@"username"] = [[PFUser currentUser] username];
            post[@"coach"] = coachString;
            post[@"isCoach"] = isCoachNumber;
            [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // The object has been saved.
                    NSLog(@"Post saved");
                    [self updateData];
                    textField.text = @"";
                } else {
                    // There was a problem, check error.description
                }
            }];
        }
        return NO;
    }
    return YES;
}
- (IBAction)logOut:(id)sender {
    [PFUser logOutInBackground];
}
@end
