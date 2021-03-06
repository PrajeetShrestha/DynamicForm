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
    NSMutableArray *cellObjects;
}
@property (nonatomic) NSString *selectedDate;


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
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    cellObjects               = [NSMutableArray new];
    needsShowConfirmation     = YES;
    self.title = self.titleString;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: PJColorFieldTitle};
    self.navigationController.navigationBar.tintColor = PJColorFieldTitle;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sections.count > 0) {
        PJSection *sectionElement = self.sections[section];
        return sectionElement.elements.count;
    } else {
        return cellDefinition.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.sections.count > 0) {
        return self.sections.count;
    } else {
        return 1;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (self.sections.count > 0) {
        PJSection *sectionElement = self.sections[section];
        PJHeader *header          = [PJHeader new];
        header.title.text         = sectionElement.name;
        return header;
    } else {
        return nil;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FieldTableViewCell *cell = (FieldTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
       [self.view endEditing:YES];
    if ([cell isKindOfClass:[PJListField class]]) {
        PJListViewController *vc   = [[PJListViewController alloc]init];
        PJListField *modelListCell = (PJListField *)cell;
        vc.titleString             = modelListCell.titleText;
        vc.delegate                = self;
        vc.indexPath               = modelListCell.indexPath;
        vc.listItems               = modelListCell.listItems;
        vc.selectionOption         = modelListCell.selectionOption;
        if (modelListCell.userSelectedRows != nil) {
            vc.userSelectedRows        = [modelListCell.userSelectedRows mutableCopy];
        }

        [self showViewController:vc sender:nil];

    } else if ([cell isKindOfClass:[PJDescription class]]) {

        DescriptionViewController *vc = [[DescriptionViewController alloc]init];
        vc.titleString                = cell.titleText;
        vc.delegate                   = self;
        vc.initialValue               = cell.value;
        vc.indexPath                  = cell.indexPath;
        [self showViewController:vc sender:nil];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self cellTypeForIndexPath:indexPath forTableView:tableView];
    return cell;
}


#pragma mark - TableView Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PJFieldHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.sections.count > 0) {
        return 44;
    } else {
        return 0;
    }
}

#pragma mark - Private Method
- (UITableViewCell *)cellTypeForIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView *)tableView {
    FieldTableViewCell *definition;
    if (self.sections.count > 0) {
       PJSection *sectionElement = self.sections[indexPath.section];
       definition                = sectionElement.elements[indexPath.row];
    } else {
       definition                = cellDefinition[indexPath.row];
    }

    NSString *cellType             = [self cellTypeForDefinitionClass:[definition class]];
    //Initialize common properties of all Cells
    FieldTableViewCell *cell       = [tableView dequeueReusableCellWithIdentifier:cellType];
    cell.key                       = definition.key;
    cell.titleText                 = definition.titleText;
    cell.isRequired                = definition.isRequired;
    cell.indexPath                 = indexPath;
    cell.delegate                  = self;
    cell.defaultValue              = definition.defaultValue;
    if(indexPath.row % 2 == 0)
        cell.backgroundColor = PJColorBackground;
    else
        cell.backgroundColor = [UIColor whiteColor];
    [self segragateValuesByTypeInCell:cell forDefinition:definition];
    [self pushCellInArray:cell];
    return cell;
}

- (void)pushCellInArray:(FieldTableViewCell *)cell {
    //Check if cell is already inserted. The cell is unique by it's indexPath
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"indexPath == %@", cell.indexPath];
    NSArray *filteredArray = [cellObjects filteredArrayUsingPredicate:predicate];
    id firstFoundObject    = nil;
    firstFoundObject       = filteredArray.count > 0 ? filteredArray.firstObject : nil;
    //If there the cellObjects array has no cell of indexPath then insert the cell into array
    if (firstFoundObject == nil) {
        [cellObjects addObject:cell];
    }
}

- (void)segragateValuesByTypeInCell:(id)cell forDefinition:(id)definition {
    Class class = [cell class];
    if (class == [PJTextField class] ) {
        PJTextField *modelTextField    = (PJTextField *)definition;
        PJTextField *textCell          = (PJTextField *)cell;
        textCell.placeholderText       = modelTextField.placeholderText;
        textCell.inputType             = modelTextField.inputType;
        [textCell setUp];

    } else if (class == [PJBoolField class]) {

        PJBoolField *boolField = (PJBoolField *)cell;
        PJBoolField *modelBoolField = (PJBoolField *)definition;
        boolField.valueWhenOn       = modelBoolField.valueWhenOn;
        boolField.valueWhenOff      = modelBoolField.valueWhenOff;
        [boolField setUp];

    } else if (class == [PJDescription class]) {

        PJDescription *descriptionCell  = (PJDescription *)cell;
        PJDescription *modelDescriptionCell = (PJDescription *)definition;
        descriptionCell.placeholderText = modelDescriptionCell.placeholderText;
        [descriptionCell setUp];

    } else if (class == [PJDatePicker class]) {

        PJDatePicker *datePicker   = (PJDatePicker *)cell;
        PJDatePicker *modelDatePicker = (PJDatePicker *)definition;
        datePicker.datePickerMode  = modelDatePicker.datePickerMode;
        datePicker.placeholderText = modelDatePicker.placeholderText;
        [datePicker setUp];

    } else if (class == [PJListField class]) {

        PJListField *listField      = (PJListField *)cell;
        PJListField *modelListField = (PJListField *)definition;
        listField.listItems         = modelListField.listItems;
        listField.selectionOption   = modelListField.selectionOption;
        listField.defaultValue      = modelListField.defaultValue;
        [listField setUp];
        
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

- (void)submitAction:(id)sender {
    [self.view endEditing:YES];
    NSMutableArray *formValues = [NSMutableArray new];
    for (FieldTableViewCell *cell in cellObjects){
        if (![cell isKindOfClass:[PJSubmitCell class]]) {
            if (cell.isValid) {
                FormValues *value = [FormValues new];
                value.key             = cell.key;
                value.value           = cell.value;
                value.validityMessage = cell.validityMessage;
                value.isValid         = cell.isValid;
                [formValues addObject:value];

            } else {
                EKToast *toast = [[EKToast alloc]initWithMessage:[NSString stringWithFormat:@"Field:  %@ \n\nMessage:  %@",cell.titleText,cell.validityMessage ]];
                toast.position = ToastPositionBottom;
                [toast show:nil];
                return;
            }
        }
    }

    EKToast *toast = [[EKToast alloc]initWithMessage:[NSString stringWithFormat:@"%@",formValues]];
    toast.position           = ToastPositionBottom;
    toast.delay              = 3.0f;
    toast.shouldAutoDestruct = NO;
    [toast show:nil];
}

#pragma mark - DescriptionViewControllerDelegate
- (void)passValue:(id)value forIndexPath:(NSIndexPath *)indexPath {
    FieldTableViewCell *definition = cellObjects[indexPath.row];
    definition.value = value;

    NSLog(@"definition value %@",definition.value);
    [definition setUp];
}

#pragma mark - PJListViewControllerDelegate
- (void)selectedValuesFromList:(NSArray *)selectedListItems fromIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"SELECTED %@",selectedListItems);
    if (selectedListItems != nil && selectedListItems.count != 0) {
        PJListField *cell     = (PJListField *)[self.tableView cellForRowAtIndexPath:indexPath];
        NSMutableArray *valueOfObjects = [NSMutableArray new];
        
        for (NSNumber *number in selectedListItems) {
            [valueOfObjects addObject:cell.listItems[number.integerValue]];
        }

        cell.value            = valueOfObjects;
        cell.userSelectedRows = selectedListItems;
        [cell setUp];
    } else {
        PJListField *cell     = (PJListField *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.value            = nil;
        cell.userSelectedRows = selectedListItems;
        [cell setUp];
    }

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
