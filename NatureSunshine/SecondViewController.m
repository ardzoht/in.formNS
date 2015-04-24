//
//  SecondViewController.m
//  NatureSunshine
//
//  Created by moviles on 3/10/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "SecondViewController.h"
#import "MemberCell.h"
#import <Parse/Parse.h>
@interface SecondViewController () {
    UIImage *image;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    PFQuery *coach = [PFQuery queryWithClassName:@"CoachGroups"];
    [coach whereKey:@"user" equalTo:[PFUser currentUser].username];
    [coach selectKeys:@[@"coach"]];
    PFObject *coachObject = [coach getFirstObject];
    coachString = coachObject[@"coach"];
    
    PFQuery *group = [PFQuery queryWithClassName:@"CoachGroups"];
    [group whereKey:@"coach" equalTo:coachString];
    [group selectKeys:@[@"user", @"profilePic"]];
    [group findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            members = objects;
            [_groupView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"memberCell";
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    PFObject *imageObject = [members objectAtIndex:indexPath.row];
    PFFile *imageFile = [imageObject objectForKey:@"profilePic"];
    
    [self.loadingSpinner startAnimating];
    self.loadingSpinner.hidden = NO;
    if(imageFile != nil) {
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.profilePic.image = [UIImage imageWithData:data];
            
        }
    }];
    }
    else {
        cell.profilePic.image = [UIImage imageNamed:@"LogoNS.jpg"];
    }
    
    
    cell.username.text = members[indexPath.row][@"user"];
    [self.loadingSpinner stopAnimating];
    self.loadingSpinner.hidden = YES;
    return cell;
}


@end
