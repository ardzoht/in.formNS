//
//  PostCell.h
//  NatureSunshine
//
//  Created by alumno on 3/21/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *post;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (nonatomic, assign)CGRect cellFrame;

@end
