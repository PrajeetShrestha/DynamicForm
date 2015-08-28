//
//  ViewController.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "ViewController.h"
#import "PJDynamicForm.h"
#import "FieldTableViewCell.h"
#import "PJTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self push:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)push:(id)sender {

    NSMutableArray *cellDefinitions = [NSMutableArray new];

    PJTextField *textField = [PJTextField new];
    textField.titleText       = @"Email Address";
    textField.isRequired      = YES;
    textField.key             = @"email";
    textField.inputType       = PJEmail;
    textField.placeholderText = @"Type your email...";
    [cellDefinitions addObject:textField];

    PJTextField *addressField = [PJTextField new];
    addressField.titleText       = @"Address";
    addressField.key             = @"address";
    addressField.isRequired      = NO;
    addressField.inputType       = PJString;
    addressField.placeholderText = @"Type your address...";
    [cellDefinitions addObject:addressField];

    PJBoolField *boolField = [PJBoolField new];
    boolField.key          = @"subscription";
    boolField.titleText    = @"Subscribe to our newsletter";
    boolField.defaultValue = @YES;
    boolField.valueWhenOff = @"NO";
    boolField.valueWhenOn  = @"YES";
    [cellDefinitions addObject:boolField];

    PJDescription *descriptionField  = [PJDescription new];
    descriptionField.key             = @"about";
    descriptionField.titleText       = @"About you!";
    descriptionField.placeholderText = @"Type your description here...";
    descriptionField.isRequired      = YES;
    descriptionField.defaultValue    = @"HEY";
    [cellDefinitions addObject:descriptionField];

    PJDatePicker *datePicker   = [PJDatePicker new];
    datePicker.key             = @"dob";
    datePicker.titleText       = @"Date of Birth";
    datePicker.isRequired      = YES;
    datePicker.placeholderText = @"Select your date of birth...";
    datePicker.datePickerMode  = UIDatePickerModeDate;
    [cellDefinitions addObject:datePicker];


    PJSubmitCell *submit = [PJSubmitCell new];
    [cellDefinitions addObject:submit];

    FieldsViewController *vc = [FieldsViewController new];
    vc.titleString = @"Registration";
    vc.cellDefinition = cellDefinitions;
    [self showViewController:vc sender:nil];
}

@end
