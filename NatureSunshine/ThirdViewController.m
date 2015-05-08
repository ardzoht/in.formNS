//
//  ThirdViewController.m
//  NatureSunshine
//
//  Created by moviles on 3/10/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "ThirdViewController.h"
#import "PhotoCell.h"
#import <Parse/Parse.h>
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    PFQuery *userCoach = [PFQuery queryWithClassName:@"CoachGroups"];
    [userCoach whereKey:@"user" equalTo:[PFUser currentUser].username];
    [userCoach selectKeys:@[@"coach"]];
    PFObject *coachObject = [userCoach getFirstObject];
    NSString *coachString = coachObject[@"coach"];

    
    // Load the items in the table
    PFQuery *group = [PFQuery queryWithClassName:@"UserPhotos"];
    [group whereKey:@"coach" equalTo:coachString];
    [group selectKeys:@[@"photo", @"user"]];
    [group findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d photos.", objects.count);
            // Do something with the found objects
            photos = objects;
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
    
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"photoCell";
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    PFObject *imageObject = [photos objectAtIndex:indexPath.row];
    NSString *user = [imageObject objectForKey:@"user"];
    PFFile *imageFile = [imageObject objectForKey:@"photo"];

    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
    if (!error) {
            cell.parallaxImage.image = [UIImage imageWithData:data];

        }
    }];
    cell.titleLabel.text = user;
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Get visible cells on table view.
    NSArray *visibleCells = [self.tableView visibleCells];
    
    for (PhotoCell *cell in visibleCells) {
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
    }
}


- (IBAction)logOut:(id)sender {
    [PFUser logOutInBackground];
}
@end
