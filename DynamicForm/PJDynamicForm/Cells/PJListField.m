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
    self.title.text = self.titleText;

    [self setupRequiredLabelVisibility];
    [super addBorders];
    self.isValid = YES;
    self.validityMessage = @"Valid!";
    if (self.defaultValue != nil && self.value == nil) {
        self.selectedValue.text = self.defaultValue;
        self.value = self.defaultValue;
    } else if ((self.defaultValue == nil && self.value == nil)) {
        self.selectedValue.text = @"- (Select) -";
    } else {
        if (self.selectionOption == PJListMultipleSelection) {
            if (self.value == nil) {
                return;
            }
            NSMutableString *string = [NSMutableString new];
            NSArray *array = (NSArray *)self.value;
            for (NSString * value in array) {
                [string appendString:[NSString stringWithFormat:@"%@, ",value]];
            }
            string = [[string substringWithRange:NSMakeRange(0, string.length - 2)] mutableCopy];
            self.selectedValue.text = string;

        } else {
            self.selectedValue.text = [NSString stringWithFormat:@"%@",self.value];
        }
    }

}

- (void)setupRequiredLabelVisibility {
    if (super.isRequired) {
        self.requiredLabel.hidden = NO;
    } else {
        self.requiredLabel.hidden = YES;
    }
}
@end
