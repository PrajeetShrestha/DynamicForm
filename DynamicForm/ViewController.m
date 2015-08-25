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

    {
        PJTextField *textField = [PJTextField new];
        textField.titleText       = @"Confirm Email";
        textField.key             = @"confirmEmail";
        textField.isRequired       = NO;
        textField.inputType       = PJString;
        textField.placeholderText = @"Confirm email...";
        [cellDefinitions addObject:textField];
    }

    PJBoolField *boolField = [PJBoolField new];
    boolField.key          = @"agreement";
    boolField.titleText    = @"Agreed";
    boolField.value        = @YES;
    boolField.valueWhenOff = @"NO";
    boolField.valueWhenOn  = @"YES";
    [cellDefinitions addObject:boolField];

    PJDescription *descriptionField  = [PJDescription new];
    descriptionField.key             = @"about";
    descriptionField.titleText       = @"About you!";
    descriptionField.placeholderText = @"Type your description here...";
    descriptionField.isRequired      = YES;
    [cellDefinitions addObject:descriptionField];
//
    PJListField *listField = [PJListField new];
    listField.key       = @"country";
    listField.titleText = @"Your Country";
    listField.listItems = @[@"Nepal",@"India",@"USA",@"China"];
    listField.defaultValue = listField.listItems[0];
    [cellDefinitions addObject:listField];

    PJSubmitCell *submit = [PJSubmitCell new];
    [cellDefinitions addObject:submit];

    FieldsViewController *vc = [FieldsViewController new];
    vc.cellDefinition = cellDefinitions;
    [self showViewController:vc sender:nil];
}

@end
