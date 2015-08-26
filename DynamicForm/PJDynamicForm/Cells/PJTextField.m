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
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *requiredLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation PJTextField

#pragma mark - Setters 

- (void)awakeFromNib {
    self.textField.delegate  = self;
    self.title.textColor     = PJColorFieldTitle;
    self.textField.textColor = PJColorFieldValue;
    self.title.font          = [UIFont systemFontOfSize:PJSizeFieldTitle];
    self.textField.font      = [UIFont systemFontOfSize:PJSizeFieldValue];
    [self.textField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
    self.containerView.layer.borderWidth  = 0.5f;
    self.containerView.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    self.containerView.layer.cornerRadius = 3.0f;
    self.containerView.clipsToBounds      = YES;
    [self sanitize];
}

- (void)textFieldDidChange:(UITextField *)textField {
    [self sanitize];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.delegate controlActivated:self];

}
- (void)sanitize {
    self.value = self.textField.text;

    if (self.isRequired) {
        if (self.textField.text.length == 0) {
            self.isValid         = NO;
            self.validityMessage = @"Required field is empty!";
            return;
        }
        if (self.inputType == PJEmail) {
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

    } else {
        if (self.textField.text.length == 0) {
            self.isValid = YES;
            self.validityMessage = @"Field is valid!";
            return;
        }

        if (self.inputType == PJEmail) {
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
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self sanitize];
    [self.delegate controlValueChanged:self];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    return YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupRequiredLabelVisibility];
    self.title.text = self.titleText;

    if (self.placeholderText != nil) {
        self.textField.placeholder = self.placeholderText;
    }
    [self sanitize];
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
- (void)setupRequiredLabelVisibility {
    if (self.isRequired) {
        self.requiredLabel.hidden = NO;
    } else {
        self.requiredLabel.hidden = YES;
    }
}
@end
