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

    PJTextField *cellDefinition = [PJTextField new];
    cellDefinition.titleText = @"Email Address";
    cellDefinition.isRequired = YES;
    cellDefinition.inputType = PJEmail;
    cellDefinition.placeholderText = @"Type your email...";
    [cellDefinitions addObject:cellDefinition];

    PJBoolField *boolField = [PJBoolField new];
    boolField.titleText = @"Agreed";
    boolField.value = @YES;
    boolField.valueWhenOff = @"NO";
    boolField.valueWhenOn = @"YES";
    [cellDefinitions addObject:boolField];

    PJDescription *descriptionField = [PJDescription new];
    descriptionField.titleText = @"About you!";
    descriptionField.placeholderText = @"Type your description here...";
    descriptionField.isRequired = YES;
    [cellDefinitions addObject:descriptionField];

    PJListField *listField = [PJListField new];
    listField.titleText = @"Your Country";
    listField.listItems = @[@"Nepal",@"India",@"USA",@"China"];
    //listField.defaultValue = listField.listItems[0];
    [cellDefinitions addObject:listField];

//    cellDefinition = [PJCellDefinition new];
//    cellDefinition.type = kPJTextField;
//    cellDefinition.title = @"Last Name";
//    cellDefinition.isRequired = YES;
//    cellDefinition.placeholder = @"Type your last name...";
//    [cellDefinitions addObject:cellDefinition];


    PJSubmitCell *submit = [PJSubmitCell new];
    [cellDefinitions addObject:submit];

    FieldsViewController *vc = [FieldsViewController new];
    vc.cellDefinition = cellDefinitions;
    [self showViewController:vc sender:nil];
}

@end
