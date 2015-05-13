//
//  TableViewCellCoach.h
//  NatureSunshine
//
//  Created by David Sáenz on 08/05/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellCoach : UITableViewCell{
    
    NSArray *ary, *ary1, *ary2;
    NSArray *count, *count1, *count2;
    NSInteger *nEntries, *nEntries1, *nEntries2;
    NSMutableArray *anAry, *anAry1, *anAry2;
    int loop;
}

- (void)configUI:(NSIndexPath *)indexPath;

@end
