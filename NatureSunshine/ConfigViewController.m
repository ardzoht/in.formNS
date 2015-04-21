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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
