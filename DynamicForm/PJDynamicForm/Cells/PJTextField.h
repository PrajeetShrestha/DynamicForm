//
//  PJTextField.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "FieldTableViewCell.h"
typedef enum PJTextFieldInputType {
    PJEmail,
    PJNumber,
    PJString,
}PJTextFieldInputType;

@interface PJTextField : FieldTableViewCell <UITextFieldDelegate>
@property (nonatomic) NSString *regex;
@property (nonatomic) PJTextFieldInputType inputType;

@end
