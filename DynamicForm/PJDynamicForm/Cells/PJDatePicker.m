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
    self.textField.delegate  = self;
    self.textField.font      = [UIFont systemFontOfSize:PJSizeFieldValue];
    self.title.font          = [UIFont systemFontOfSize:PJSizeFieldTitle];
}

- (void)pickerSelected:(id)picker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSString *formatedDate         = [dateFormatter stringFromDate:self.datePicker.date];
    self.selectedDate              = formatedDate;
    self.textField.text            = self.selectedDate;
    [self sanitize];
    NSLog(@"%@",self.value);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        [self.delegate didSelectedCell:nil sender:self];
    } else {

    }
}
- (void)layoutSubviews {

    [self setupRequiredLabelVisibility];
    self.datePicker                 = [UIDatePicker new];
    self.datePicker.datePickerMode  = self.datePickerMode;
    self.datePicker.backgroundColor = [UIColor whiteColor];
    [self.datePicker addTarget:self action:@selector(pickerSelected:) forControlEvents:UIControlEventValueChanged];
    self.textField.inputView = self.datePicker;
    [self sanitize];
    [super addBorders];
}

- (void)setupRequiredLabelVisibility {
    if (self.isRequired) {
        self.requiredLabel.hidden = NO;
    } else {
        self.requiredLabel.hidden = YES;
    }
}
#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return NO;
}

- (void)sanitize {
    self.value = self.textField.text;
    self.textField.placeholder = self.placeholderText;
    if (self.isRequired && self.textField.text.length == 0) {
            self.isValid         = NO;
            self.validityMessage = @"Required field is empty!";
            return;
    } else {

            self.isValid = YES;
            self.validityMessage = @"Field is valid!";
            return;
    }
}
@end
