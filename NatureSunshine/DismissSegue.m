//
//  DismissSegue.m
//  NatureSunshine
//
//  Created by David Sáenz on 15/04/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "DismissSegue.h"

@implementation DismissSegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    [sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
