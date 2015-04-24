//
//  FirstViewController.h
//  NatureSunshine
//
//  Created by moviles on 3/10/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    
    NSArray *posts;
    NSString *coachString;
    NSString *type;
    
}
@property (weak, nonatomic) IBOutlet UITableView *wallView;
@property (weak, nonatomic) IBOutlet UITextField *sender;


@end

