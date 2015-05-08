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


- (void)configUI:(NSIndexPath *)indexPath{
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
    count = [query findObjects];
    
    
    PFQuery *query1 = [PFQuery queryWithClassName:@"Calories"];
    [query1 whereKey:@"username" equalTo:userN];
    [query1 selectKeys:@[@"nCalories"]];
    count1 = [query1 findObjects];
    
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"Weight"];
    [query2 whereKey:@"username" equalTo:userN];
    [query2 selectKeys:@[@"nPounds"]];
    count2 = [query2 findObjects];
    

    nEntries = (NSInteger)count.count;
    nEntries1 = (NSInteger)count1.count;
    nEntries2 = (NSInteger)count2.count;
    
    
    switch (path.section) {
        case 0:
            return [self getXTitles:nEntries];
        case 1:
            return [self getXTitles:nEntries1];
        case 2:
            return [self getXTitles:nEntries2];
            
        default:
            break;
    }
    
    return [self getXTitles:nEntries];
}


//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart{
  
    PFUser *currentUser = [PFUser currentUser];
    NSString *userN = [currentUser username];
    NSLog(@"%@", currentUser.username);
    
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
    return CGRangeZero;
}


#pragma mark 折线图专享功能
//标记数值区域
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
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
