//
//  ThirdViewController.h
//  NatureSunshine
//
//  Created by moviles on 3/10/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *photos;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
- (IBAction)logOut:(id)sender;




@end
