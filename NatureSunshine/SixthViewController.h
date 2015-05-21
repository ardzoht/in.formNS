//
//  SixthViewController.h
//  NatureSunshine
//
//  Created by moviles on 3/10/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SixthViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate>{
    
    IBOutlet UILabel *messageForEachSegmented;

    IBOutlet UILabel *optionLabel;

    IBOutlet UITextField *dataTxtField;
    
    IBOutlet UISegmentedControl *mySegmentedControl;
    
    IBOutlet UILabel *confirmationLabel;

}

- (IBAction)segmentedValue:(id)sender;

- (IBAction)sendTrackerData:(id)sender;

- (IBAction)showGraphs:(id)sender;

- (IBAction)logout:(id)sender;

@property (nonatomic, retain) NSString *userData;


@end
