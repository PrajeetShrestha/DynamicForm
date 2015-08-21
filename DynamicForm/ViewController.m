//
//  ViewController.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "ViewController.h"
#import "PJDynamicForm.h"

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
    PJCellDefinition *cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJTextField;
    cellDefinition.title = @"Name";
    cellDefinition.placeholder = @"Greetings";
    cellDefinition.value = @"Type your description here!";
    cellDefinition.isRequired = YES;
    cellDefinition.placeholder = @"Type your name...";
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJDescription;
    cellDefinition.title = @"Address";
    cellDefinition.placeholder = @"Greetings";
    cellDefinition.isRequired = YES;
    cellDefinition.value = @"This is so cool!";
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJListField;
    cellDefinition.title = @"This is List Field";
    cellDefinition.placeholder = @"Greetings";
    cellDefinition.value = @"Select One Value";
    cellDefinition.isRequired = NO;
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJBoolField;
    cellDefinition.title = @"Need a tutor? (Yes/No)";
    cellDefinition.placeholder = @"Greetings";
    cellDefinition.value = @"OH SOUKA";
    cellDefinition.isRequired = YES;
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJTextField;
    cellDefinition.title = @"How are you";
    cellDefinition.placeholder = @"Greetings";
    cellDefinition.value = @"OH SOUKA";
    cellDefinition.isRequired = YES;
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJTextField;
    cellDefinition.title = @"How are you";
    cellDefinition.placeholder = @"Greetings";
    cellDefinition.value = @"OH SOUKA";
    cellDefinition.isRequired = YES;
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJTextField;
    cellDefinition.title = @"How are you";
    cellDefinition.placeholder = @"Greetings";
    cellDefinition.value = @"OH SOUKA";
    cellDefinition.isRequired = YES;
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJTextField;
    cellDefinition.title = @"How are you";
    cellDefinition.placeholder = @"Greetings";
    cellDefinition.value = @"OH SOUKA";
    cellDefinition.isRequired = YES;
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJTextField;
    cellDefinition.title = @"How are you";
    cellDefinition.placeholder = @"Greetings";
    cellDefinition.value = @"OH SOUKA";
    cellDefinition.isRequired = YES;
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJTextField;
    cellDefinition.title = @"How are you";
    cellDefinition.placeholder = @"Greetings";
    cellDefinition.value = @"OH SOUKA";
    cellDefinition.isRequired = YES;
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJTextField;
    cellDefinition.title = @"How are you";
    cellDefinition.placeholder = @"Greetings";
    cellDefinition.value = @"OH SOUKA";
    cellDefinition.isRequired = NO;
    [cellDefinitions addObject:cellDefinition];

    FieldsViewController *vc = [FieldsViewController new];
    vc.cellDefinition = cellDefinitions;
    [self showViewController:vc sender:nil];
}

@end
