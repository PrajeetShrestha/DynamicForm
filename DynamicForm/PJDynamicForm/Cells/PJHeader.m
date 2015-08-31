//
//  PJHeader.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/31/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "PJHeader.h"

@implementation PJHeader
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"PJHeader" owner:self options:nil][0];
    }
    return self;
}


@end
