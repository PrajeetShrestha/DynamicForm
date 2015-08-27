//
//  PJTextField.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "PJTextField.h"

//RFC 5322 Standard
static NSString *defaultEmailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
@interface PJTextField ()

@end

@implementation PJTextField

#pragma mark - Setters 

- (void)awakeFromNib {
    self.textField.delegate  = self;
    self.title.textColor     = PJColorFieldTitle;
    self.textField.textColor = PJColorFieldValue;
    self.title.font          = [UIFont systemFontOfSize:PJSizeFieldTitle];
    self.textField.font      = [UIFont systemFontOfSize:PJSizeFieldValue];
}

- (void)setUp {
    [self checkValidityAndUpdateValue];
    [self manageInputKeyboard];
    [self.textField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];

    self.textField.placeholder = self.placeholderText;
    self.title.text            = self.titleText;
    [self setupRequiredLabelVisibilityIfIsRequired:self.isRequired];
}

- (void)manageInputKeyboard {
    if (self.inputType == PJEmail) {
        self.textField.keyboardType = UIKeyboardTypeEmailAddress;;
    } else if (self.inputType == PJNumber) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    } else if (self.inputType == PJString) {
        self.textField.keyboardType = UIKeyboardTypeDefault;
    } else {
        self.textField.keyboardType = UIKeyboardTypeDefault;
    }
}

- (void)checkValidityAndUpdateValue {
    self.value = self.textField.text;
    if (self.isRequired && self.textField.text.length == 0) {

        self.isValid         = NO;
        self.validityMessage = @"Required field is empty!";

    } else if (self.textField.text.length > 0) {
        switch (self.inputType) {
            case PJEmail:
                [self validateEmail];
                break;
            case PJNumber:
                break;
            case PJString:
                break;
            default:
                break;
        }
    } else {
        self.isValid = YES;
        self.validityMessage = @"Field is valid!";

    }
}

- (void)validateEmail {
    NSString *regex;
    //Check if user has provided any regex for the textField
    if (self.regex == nil) {
        regex = defaultEmailRegex;
    } else {
        regex = self.regex;
    }
    NSPredicate *myTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    if ([myTest evaluateWithObject: self.textField.text]){
        self.isValid         = YES;
        self.validityMessage = @"Field is valid!";
    } else {
        self.validityMessage = @"Email Expression not correct";
        self.isValid         = NO;
    }
}

#pragma mark - TextField Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self checkValidityAndUpdateValue];
    [self.delegate controlValueChanged:self];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.delegate controlActivated:self];
}

#pragma mark - Textfield Actions
- (void)textFieldDidChange:(UITextField *)textField {
    [self checkValidityAndUpdateValue];
}

#pragma mark - Public
- (void)setupRequiredLabelVisibilityIfIsRequired:(BOOL)isRequired {
    if (isRequired) {
        self.requiredLabel.hidden = NO;
    } else {
        self.requiredLabel.hidden = YES;
    }
}
@end
