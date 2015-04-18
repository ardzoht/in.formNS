//
//  SixthViewController.h
//  NatureSunshine
//
//  Created by moviles on 3/10/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SixthViewController : UIViewController{
    
    IBOutlet UILabel *messageForEachSegmented;

    IBOutlet UILabel *optionLabel;

    IBOutlet UITextField *dataTxtField;
    
    IBOutlet UISegmentedControl *mySegmentedControl;
    
    IBOutlet UILabel *confirmationLabel;
    
    IBOutlet UILabel *confirmedData;
}

- (IBAction)segmentedValue:(id)sender;

- (IBAction)sendTrackerData:(id)sender;





@end
