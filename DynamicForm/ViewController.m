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
    cellDefinition.title = @"First Name";
    cellDefinition.isRequired = YES;
    cellDefinition.placeholder = @"Type your name...";
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJTextField;
    cellDefinition.title = @"Last Name";
    cellDefinition.isRequired = YES;
    cellDefinition.placeholder = @"Type your last name...";
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJTextField;
    cellDefinition.title = @"Email Address";
    cellDefinition.isRequired = YES;
    cellDefinition.placeholder = @"Type your email_id...";
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJTextField;
    cellDefinition.title = @"Desired Username";
    cellDefinition.isRequired = YES;
    cellDefinition.placeholder = @"Type your desired username...";
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJTextField;
    cellDefinition.title = @"Affiliation";
    cellDefinition.isRequired = YES;
    cellDefinition.placeholder = @"Type your affiliation...";
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJDescription;
    cellDefinition.title = @"Reason for account";
    cellDefinition.isRequired = YES;
    cellDefinition.placeholder = @"Type reason for your account...";
    [cellDefinitions addObject:cellDefinition];

    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJListField;
    cellDefinition.title = @"User Type";
    cellDefinition.isRequired = YES;
    cellDefinition.placeholder = @"Select User Type...";
    cellDefinition.dataArray = @[@"Student",@"Faculty",@"Staff",@"Other"];
    cellDefinition.value = @"User Type";
    [cellDefinitions addObject:cellDefinition];





    cellDefinition = [PJCellDefinition new];
    cellDefinition.type = kPJSubmitCell;

    [cellDefinitions addObject:cellDefinition];


    FieldsViewController *vc = [FieldsViewController new];
    vc.cellDefinition = cellDefinitions;
    [self showViewController:vc sender:nil];
}

@end
