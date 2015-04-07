//
//  PhotoCell.h
//  NatureSunshine
//
//  Created by alumno on 4/7/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *parallaxImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
