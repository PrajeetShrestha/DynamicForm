//
//  PJDescription.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "PJDescription.h"
#import "DescriptionViewController.h"

@implementation PJDescription
- (void)awakeFromNib {

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [self.delegate didSelected:([DescriptionViewController class]) sender:self];
    } else {

    }
}

- (void)layoutSubviews {
    self.lblDescription.text = self.value;
}

@end