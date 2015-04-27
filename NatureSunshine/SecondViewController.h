//
//  SecondViewController.h
//  NatureSunshine
//
//  Created by moviles on 3/10/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *members;
    NSString *coachString;
    
}


@property (weak, nonatomic) IBOutlet UITableView *groupView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;



@end

