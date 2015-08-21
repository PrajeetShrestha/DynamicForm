//
//  PJTextField.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "PJTextField.h"

@implementation PJTextField


- (void)awakeFromNib {
    self.type = @"PJTextField";
    self.textField.delegate = self;
    self.title.textColor = PJColorFieldTitle;
    self.textField.textColor = PJColorFieldValue;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.delegate controlActivated:self];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self.delegate controlValueChanged:[NSString stringWithFormat:@"%@%@",textField.text,string]
                                sender:self];
    return YES;
}

- (void)layoutSubviews {
    [self setupRequiredLabelVisibility];
}
- (void)setupRequiredLabelVisibility {
    if (self.isRequired) {
        self.requiredLabel.hidden = NO;
    } else {
        self.requiredLabel.hidden = YES;
    }
}
@end
