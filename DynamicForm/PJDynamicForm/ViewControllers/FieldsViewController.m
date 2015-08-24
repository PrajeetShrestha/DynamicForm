//
//  FieldsViewController.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "DescriptionViewController.h"
#import "PJListViewController.h"
#import "FieldsViewController.h"
#import "PJDynamicForm.h"

@interface FieldsViewController ()<FieldTableViewCell,DescriptionViewControllerDelegate,PJListViewControllerDelegate> {
    BOOL needsShowConfirmation;
}

@end

@implementation FieldsViewController
@synthesize cellDefinition;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [self initWithNibName:@"FieldsViewController" bundle:[NSBundle mainBundle]];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    needsShowConfirmation = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cellDefinition.count;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self cellTypeForIndexPath:indexPath forTableView:tableView];
    return cell;
}


#pragma mark - TableView Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

#pragma mark - Private Method
- (UITableViewCell *)cellTypeForIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView *)tableView {
    FieldTableViewCell *definition = cellDefinition[indexPath.row];
    NSString *cellType = [self cellTypeForDefinitionClass:[definition class]];
    FieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
    //Initialize common properties of all Cells
    cell.titleText          = definition.titleText;
    cell.placeholderText    = definition.placeholderText;
    cell.isRequired         = definition.isRequired;
    cell.indexPath          = indexPath;
    cell.delegate           = self;
    cell.defaultValue       = definition.defaultValue;
    cell.isEnabled          = definition.isEnabled;
    [self segragateValuesByTypeInCell:cell forDefinition:definition];
    return cell;
}

- (void)segragateValuesByTypeInCell:(id)cell forDefinition:(id)definition {
    Class class = [cell class];
    if (class == [PJTextField class] ) {
        PJTextField *textCell = (PJTextField *)cell;
        textCell.inputType = PJEmail;

    } else if (class == [PJBoolField class]) {

    } else if (class == [PJDatePicker class]) {

    } else if (class == [PJDescription class]) {

    } else if (class == [PJListField class]) {

    } else if (class == [PJSubmitCell class]) {

    } else {

    }

}

- (NSString *)cellTypeForDefinitionClass:(Class)class {
    NSString *cellType;
    if (class == [PJTextField class] ) {
        cellType = kPJTextField;
        return cellType;
    } else if (class == [PJBoolField class]) {
        cellType = kPJBoolField;
        return cellType;
    } else if (class == [PJDatePicker class]) {
        cellType = kPJDatePicker;
        return cellType;
    } else if (class == [PJDescription class]) {
        cellType = kPJDescription;
        return cellType;
    } else if (class == [PJListField class]) {
        cellType = kPJListField;
        return cellType;
    } else if (class == [PJSubmitCell class]) {
        cellType = kPJSubmitCell;
        return cellType;
    } else {
        return nil;
    }

}
#pragma mark - FieldTableViewCellDelegate
- (void)didSelected:(Class)viewController sender:(FieldTableViewCell *)cell {
    if (viewController == [DescriptionViewController class]) {
        DescriptionViewController *vc = [[viewController alloc]init];
        vc.delegate = self;
        vc.initialValue = cell.value;
        vc.indexPath = cell.indexPath;
        [self showViewController:vc sender:nil];
    } else if (viewController == [PJListViewController class]) {
        PJListViewController *vc = [[PJListViewController alloc]init];
        vc.dataArray = nil;
        vc.delegate = self;
        vc.indexPath = cell.indexPath;
        vc.dataArray = cell.dataArray;
        [self showViewController:vc sender:nil];
    }
}

- (void)controlActivated:(id)sender {
    //FieldTableViewCell *cell = (FieldTableViewCell *)sender;
    //TODO: Future upgrade
    //Dynamic Form view scroll.
    //CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:cell.indexPath];
    //CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
    //NSLog(@"%@ RECT IN SUPERVIEW " ,NSStringFromCGRect(rectInSuperview));
}

- (void)submitAction:(id)sender {
    [self.view endEditing:YES];
    for (FieldTableViewCell *definition in cellDefinition){
        if (![definition isKindOfClass:[PJSubmitCell class]]) {
            if (!definition.isValid) {
                NSLog(@"Message:%@ Value: %@",definition.invalidMessage,definition.value);
            }
        }
    }
}

- (void)controlValueChanged:(FieldTableViewCell *)cell {
    FieldTableViewCell *definition = cellDefinition[cell.indexPath.row];
    definition.invalidMessage = cell.invalidMessage;
    definition.value = cell.value;

}
#pragma mark - DescriptionViewControllerDelegate
- (void)passValue:(id)value forIndexPath:(NSIndexPath *)indexPath {
    FieldTableViewCell *definition = cellDefinition[indexPath.row];
    definition.value = value;
    [self.tableView reloadData];
}

#pragma mark - PJListViewControllerDelegate
- (void)selectedItemInList:(id)value forCellAtIndexPath:(NSIndexPath *)indexPath {
    FieldTableViewCell *definition = cellDefinition[indexPath.row];
    definition.value = value;
    [self.tableView reloadData];
}

#pragma mark - UIViewController+BackButtonHandler
-(BOOL) navigationShouldPopOnBackButton {
    if(needsShowConfirmation) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Confirm your action!" message:@"All the changes you have done in the form will be lost. Do you really want to go back?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok" , nil];
        [alert show ];
        return NO; // Ignore 'Back' button this time
    }
    return YES; // Process 'Back' button click and Pop view controler
}
#pragma mark - AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        needsShowConfirmation = NO;
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        needsShowConfirmation = YES;
    }
}


@end
