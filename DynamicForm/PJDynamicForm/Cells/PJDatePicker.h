//
//  PJDatePicker.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "FieldTableViewCell.h"

@interface PJDatePicker : FieldTableViewCell <UITextFieldDelegate>
@property (nonatomic) UIDatePickerMode datePickerMode;
@property (nonatomic) NSString         *placeholderText;
@end
