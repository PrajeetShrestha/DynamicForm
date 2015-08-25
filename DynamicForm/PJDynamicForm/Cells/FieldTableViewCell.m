//
//  FieldTableViewCell.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "FieldTableViewCell.h"

@implementation FieldTableViewCell

- (void)awakeFromNib {

}

- (void)layoutSubviews {
    self.validityMessage = @"Not Available";
    self.value = @"";
    self.isValid = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
