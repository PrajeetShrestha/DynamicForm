//
//  PJListField.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/21/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "PJListField.h"
@interface PJListField ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *selectedValue;
@property (weak, nonatomic) IBOutlet UILabel *requiredLabel;
@end
@implementation PJListField

- (void)awakeFromNib {
    self.title.textColor         = PJColorFieldTitle;
    self.selectedValue.textColor = PJColorFieldValue;
    self.title.font              = [UIFont systemFontOfSize:PJSizeFieldTitle];
    self.selectedValue.font      = [UIFont systemFontOfSize:PJSizeFieldValue];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [self.delegate didSelected:([PJListViewController class]) sender:self];
    } else {

    }
}

- (void)layoutSubviews {
    if (self.defaultValue != nil && self.value == nil) {
        self.selectedValue.text = self.defaultValue;
    } else if (self.defaultValue == nil && self.value == nil) {
        self.selectedValue.text = @"- (Select One) -";
    } else {
        self.selectedValue.text = [NSString stringWithFormat:@"%@",self.value];
    }
    self.title.text = self.titleText;

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
