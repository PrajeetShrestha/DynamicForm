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

    PJDescription *descriptionField  = [PJDescription new];
    descriptionField.key             = @"about";
    descriptionField.titleText       = @"About you!";
    descriptionField.placeholderText = @"Type your description here...";
    descriptionField.isRequired      = YES;
    [cellDefinitions addObject:descriptionField];

    PJDatePicker *datePicker   = [PJDatePicker new];
    datePicker.key             = @"dob";
    datePicker.titleText       = @"Date of Birth";
    datePicker.isRequired      = YES;
    datePicker.placeholderText = @"Select your date of birth...";
    datePicker.datePickerMode  = UIDatePickerModeDate;
    [cellDefinitions addObject:datePicker];

    PJListField *listField = [PJListField new];
    listField.key          = @"country";
    listField.titleText    = @"Country";
    listField.listItems    = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26"];
    listField.isRequired   = YES;
//    listField.defaultValue = listField.listItems[0];
    listField.selectionOption = PJListMultipleSelection;
    [cellDefinitions addObject:listField];

    PJBoolField *boolField = [PJBoolField new];
    boolField.key          = @"subscription";
    boolField.titleText    = @"Subscribe to our newsletter";
    boolField.value        = @YES;
    boolField.valueWhenOff = @"NO";
    boolField.valueWhenOn  = @"YES";
    [cellDefinitions addObject:boolField];

    PJSubmitCell *submit = [PJSubmitCell new];
    [cellDefinitions addObject:submit];

    FieldsViewController *vc = [FieldsViewController new];
    vc.titleString = @"Regsitration";
    vc.cellDefinition = cellDefinitions;
    [self showViewController:vc sender:nil];
}

@end
