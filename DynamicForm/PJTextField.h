//
//  PJTextField.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "FieldTableViewCell.h"

@interface PJTextField : FieldTableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
