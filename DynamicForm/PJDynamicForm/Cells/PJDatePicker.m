//
//  PJDatePicker.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "PJDatePicker.h"
@interface PJDatePicker ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *requiredLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) NSString *selectedDate;
@property (nonatomic) UIDatePicker *datePicker;
@end
@implementation PJDatePicker

- (void)awakeFromNib {
    self.title.textColor     = PJColorFieldTitle;
    self.textField.textColor = PJColorFieldValue;
    self.textField.font      = [UIFont systemFontOfSize:PJSizeFieldValue];
    self.title.font          = [UIFont systemFontOfSize:PJSizeFieldTitle];
    self.datePicker = [UIDatePicker new];
    [self.datePicker addTarget:self action:@selector(pickerSelected:) forControlEvents:UIControlEventTouchUpInside];

    self.textField.inputView = [UIDatePicker new];

}


- (void)pickerSelected:(id)picker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];

    NSString *formatedDate = [dateFormatter stringFromDate:self.datePicker.date];

    self.selectedDate = formatedDate;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [self.delegate didSelected:nil sender:self];
    } else {

    }
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
