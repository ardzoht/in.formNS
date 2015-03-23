//
//  FirstViewController.h
//  NatureSunshine
//
//  Created by moviles on 3/10/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray *posts;
    NSMutableArray *people;
    NSMutableArray *pics;
    
}
@property (weak, nonatomic) IBOutlet UITableView *wallView;


@end

