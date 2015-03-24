//
//  PostCell.m
//  NatureSunshine
//
//  Created by alumno on 3/21/15.
//  Copyright (c) 2015 Alex&Dave. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

-(void) setFrame:(CGRect) frame {
    
    frame.origin.x += 10;
    frame.size.width = self.superview.frame.size.width - (2.0f * 10);
    [super setFrame: frame];
}
@end
