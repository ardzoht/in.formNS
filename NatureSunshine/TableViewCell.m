//
//  TableViewCell.m
//  NatureSunshine
//
//  Created by David Sáenz on 22/04/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "TableViewCell.h"
#import "UUChart.h"
#import <Parse/Parse.h>

@interface TableViewCell ()<UUChartDataSource>
{
    NSIndexPath *path;
    UUChart *chartView;
}
@end

@implementation TableViewCell

- (void)configUI:(NSIndexPath *)indexPath
{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    path = indexPath;
    
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 150)
                                              withSource:self
                                               withStyle:indexPath.section==1?UUChartLineStyle:UUChartLineStyle];
    [chartView showInView:self.contentView];
}

- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"R-%d",i];
        [xTitles addObject:str];
    }
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{    
    PFUser *currentUser = [PFUser currentUser];
    NSString *userN = [[NSString alloc] initWithFormat:@"%@", currentUser.username];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Water"];
    [query whereKey:@"username" equalTo:userN];
    [query selectKeys:@[@"nOunces"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            nEntries = [NSNumber numberWithUnsignedInteger:objects.count];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFQuery *query1 = [PFQuery queryWithClassName:@"Calories"];
    [query1 whereKey:@"username" equalTo:userN];
    [query1 selectKeys:@[@"nCalories"]];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            nEntries1 = [NSNumber numberWithUnsignedInteger:objects.count];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"Weight"];
    [query2 whereKey:@"username" equalTo:userN];
    [query2 selectKeys:@[@"nPounds"]];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            nEntries2 = [NSNumber numberWithUnsignedInteger:objects.count];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    if (path.section==0) {
        return [self getXTitles:[nEntries intValue]];
    }
     else{
         if(path.section==1){
             return [self getXTitles:[nEntries1 intValue]];
         }
         
         else{
             return [self getXTitles:[nEntries2 intValue]];
         }
    }
    return [self getXTitles:20];
}


//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart{
    /*
     NSArray *ary = @[@"22",@"44",@"15",@"40",@"42"];
     NSArray *ary1 = @[@"22",@"54",@"15",@"30",@"42",@"77",@"43"];
     NSArray *ary2 = @[@"76",@"34",@"54",@"23",@"16",@"32",@"17"];
     NSArray *ary3 = @[@"3",@"12",@"25",@"55",@"52"];
     NSArray *ary4 = @[@"23",@"42",@"25",@"15",@"30",@"42",@"32",@"40",@"42",@"25",@"33"]; */
    
    PFUser *currentUser = [PFUser currentUser];
    NSString *userN = [[NSString alloc] initWithFormat:@"%@", currentUser.username];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Water"];
    [query whereKey:@"username" equalTo:userN];
    [query selectKeys:@[@"nOunces"]];
    ary = [query findObjects];
    
    NSMutableArray *values = [[NSMutableArray alloc]init];
    for(PFObject *object in ary) {
        [values addObject:object[@"nOunces"]];
    }
    
    PFQuery *query1 = [PFQuery queryWithClassName:@"Calories"];
    [query1 whereKey:@"username" equalTo:userN];
    [query1 selectKeys:@[@"nCalories"]];
    ary1 = [query1 findObjects];
    
    NSMutableArray *values1 = [[NSMutableArray alloc]init];
    for(PFObject *object in ary1) {
        [values1 addObject:object[@"nCalories"]];
    }
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"Weight"];
    [query2 whereKey:@"username" equalTo:userN];
    [query2 selectKeys:@[@"nPounds"]];
    ary2 = [query2 findObjects];
    
    NSMutableArray *values2 = [[NSMutableArray alloc]init];
    for(PFObject *object in ary2) {
        [values2 addObject:object[@"nPounds"]];
    }
    
    if (path.section == 0) {
           return @[values];
    }
    else{
        if(path.section == 1){
            return @[values1];
      }
        else{
            return @[values2];
        }
    }
}

#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UUGreen,UURed,UUBrown];
}
//显示数值范围
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    if (path.section==0 && (path.row==0|path.row==1)) {
        return CGRangeMake(60, 10);
    }
    if (path.section==1 && path.row==0) {
        return CGRangeMake(60, 10);
    }
    if (path.row==2) {
        return CGRangeMake(100, 0);
    }
    return CGRangeZero;
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    if (path.row==2) {
        return CGRangeMake(25, 75);
    }
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return path.row==2;
}
@end
