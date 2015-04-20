//
//  ConfigViewController.h
//  NatureSunshine
//
//  Created by alumno on 4/19/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *heightText;
@property (weak, nonatomic) IBOutlet UITextField *weightText;
@property (weak, nonatomic) IBOutlet UISegmentedControl *waterTrack;
@property (weak, nonatomic) IBOutlet UITextView *objectiveText;
@property (weak, nonatomic) IBOutlet UIPickerView *coaches;
@property (weak, nonatomic) IBOutlet UIButton *send;


@end
