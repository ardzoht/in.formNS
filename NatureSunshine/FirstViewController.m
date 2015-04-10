//
//  FirstViewController.m
//  NatureSunshine
//
//  Created by moviles on 3/10/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "FirstViewController.h"
#import "PostCell.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    posts = [[NSMutableArray alloc]init];
    people = [[NSMutableArray alloc]init];
    types = [[NSMutableArray alloc]init];
    [posts addObject:@"This is awesome! Trying it for the first time guys"];
    [posts addObject:@"Guys, nice session today, we'll be in touch."];
    [posts addObject:@"Great time today with my friends at the session, looking forward to a great week"];
    
    [people addObject:@"Clark Kent"];
    [people addObject:@"Coach Carter"];
    [people addObject:@"John Doe"];
    
    [types addObject:@"member"];
    [types addObject:@"coach"];
    [types addObject:@"member"];
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
    
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

    
    cell.post.text = [posts objectAtIndex:indexPath.row];
    cell.name.text = [people objectAtIndex:indexPath.row];
    cell.type.text = [types objectAtIndex:indexPath.row];
    return cell;
}

@end
