//
//  TableViewCell.h
//  NatureSunshine
//
//  Created by David Sáenz on 22/04/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell{
 
    NSArray *ary, *ary1, *ary2;
    NSNumber *nEntries, *nEntries1, *nEntries2;
}

- (void)configUI:(NSIndexPath *)indexPath;

@end
