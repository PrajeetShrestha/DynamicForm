//
//  PJDescription.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "PJDescription.h"
#import "DescriptionViewController.h"
@interface PJDescription()

@property (weak, nonatomic) IBOutlet UITextField *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel * title;
@property (weak, nonatomic) IBOutlet UILabel * requiredLabel;
@end

@implementation PJDescription

- (void)awakeFromNib {
    self.title.textColor          = PJColorFieldTitle;
    self.lblDescription.textColor = PJColorFieldValue;
    self.title.font               = [UIFont systemFontOfSize:PJSizeFieldTitle];
    self.lblDescription.font      = [UIFont systemFontOfSize:PJSizeFieldValue];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       [self.delegate didSelected:([DescriptionViewController class]) sender:self];
    } else {

    }
}

- (void)layoutSubviews {
    if (self.value != nil) {
        self.lblDescription.text        = self.value;
    } else {
        self.lblDescription.placeholder = self.placeholderText;
    }

    self.title.text          = self.titleText;
    if (self.value == nil && self.isRequired) {
        self.validityMessage = @"Required Field Empty!";
        self.isValid = NO;
    } else {
        self.validityMessage = @"Valid data!";
        self.isValid = YES;
    }

    [self setupRequiredLabelVisibility];
}

- (void)setupRequiredLabelVisibility {
    if (super.isRequired) {
        self.requiredLabel.hidden = NO;
    } else {
        self.requiredLabel.hidden = YES;
    }
}

@end
