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
    return PJFieldHeight;
}

#pragma mark - Private Method
- (UITableViewCell *)cellTypeForIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView *)tableView {
    FieldTableViewCell *definition = cellDefinition[indexPath.row];
    NSString *cellType             = [self cellTypeForDefinitionClass:[definition class]];
    //Initialize common properties of all Cells
    FieldTableViewCell *cell       = [tableView dequeueReusableCellWithIdentifier:cellType];
    cell.titleText                 = definition.titleText;
    cell.isRequired                = definition.isRequired;
    cell.indexPath                 = indexPath;
    cell.delegate                  = self;
    cell.defaultValue              = definition.defaultValue;
    cell.isEnabled                 = definition.isEnabled;
    cell.value                     = definition.value;
    cell.key                       = definition.key;
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

        PJTextField *textCell    = (PJTextField *)cell;
        textCell.placeholderText = [definition valueForKey:@"placeholderText"];
        textCell.inputType = [[definition valueForKey:@"inputType"] intValue];

    } else if (class == [PJBoolField class]) {

        PJBoolField *boolField = (PJBoolField *)cell;
        boolField.valueWhenOn  = [definition valueForKey:@"valueWhenOn"];
        boolField.valueWhenOff = [definition valueForKey:@"valueWhenOff"];

    } else if (class == [PJDescription class]) {

        PJDescription *descriptionCell  = (PJDescription *)cell;
        descriptionCell.placeholderText = [definition valueForKey:@"placeholderText"];

    } else if (class == [PJDatePicker class]) {

        PJDatePicker *datePicker   = (PJDatePicker *)cell;
        datePicker.datePickerMode  = [[definition valueForKey:@"datePickerMode"] intValue];
        datePicker.placeholderText = [definition valueForKey:@"placeholderText"];

    } else if (class == [PJListField class]) {

        PJListField *listField  = (PJListField *)cell;
        listField.listItems     = [definition valueForKey:@"listItems"];
        listField.defaultValue  = [definition valueForKey:@"defaultValue"];
        if (listField.defaultValue != nil) {
            listField.indexPathsOfSelectedItem = [NSIndexPath indexPathForRow:[listField.listItems indexOfObject:listField.defaultValue] inSection:0];
        }
        listField.selectionOption = [[definition valueForKey:@"selectionOption"] intValue];

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
    [self.view endEditing:YES];
    if (viewController == [DescriptionViewController class]) {
        DescriptionViewController *vc = [[viewController alloc]init];
        vc.titleString                = cell.titleText;
        vc.delegate                   = self;
        vc.initialValue               = cell.value;
        vc.indexPath                  = cell.indexPath;
        [self showViewController:vc sender:nil];

    } else if (viewController == [PJListViewController class]) {

        PJListViewController *vc = [[PJListViewController alloc]init];
        vc.titleString   = cell.titleText;
        vc.delegate      = self;
        vc.indexPath     = cell.indexPath;
        vc.listItems     = [cell valueForKey:@"listItems"];
        //vc.selectionType = [[cell valueForKey:@"selectionType"] intValue];
        if ([cell valueForKey:@"indexPathsOfSelectedItem"] != nil) {
            vc.indexPathOfSelectedItem = [cell valueForKey:@"indexPathsOfSelectedItem"];
        }
        vc.selectionOption = [[cell valueForKey:@"selectionOption"] intValue];
        [self showViewController:vc sender:nil];

    } else if ([cell isKindOfClass:[PJDatePicker class]]) {
        //Date Picker Selected;

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
    toast.position = ToastPositionBottom;
    toast.delay = 3.0f;
    toast.shouldAutoDestruct = NO;
    [toast show:nil];
}

- (void)controlValueChanged:(FieldTableViewCell *)cell {

}
#pragma mark - DescriptionViewControllerDelegate
- (void)passValue:(id)value forIndexPath:(NSIndexPath *)indexPath {
    FieldTableViewCell *definition = cellObjects[indexPath.row];
    definition.value = value;
    [definition layoutSubviews];
}

#pragma mark - PJListViewControllerDelegate
- (void)selectedItemInList:(id)value forCellAtIndexPath:(NSIndexPath *)indexPath andSelectedIndex:(id)selectedIndex {
    PJListField *definition = cellObjects[indexPath.row];
    if (definition.selectionOption == PJListSingleSelection) {
        definition.indexPathsOfSelectedItem = selectedIndex;
        definition.value                   = value;
        [definition layoutSubviews];
    } else if (definition.selectionOption == PJListMultipleSelection) {
        definition.value = value;
        [definition layoutSubviews] ;
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


#pragma mark - References
/*
 for (FieldTableViewCell *definition in cellDefinition){
 Class class = [definition class];
 if (class == [PJTextField class] ) {
 PJTextField *textField = (PJTextField *)definition;
 } else if (class == [PJBoolField class]) {
 PJBoolField *boolField = (PJBoolField *)definition;
 } else if (class == [PJDatePicker class]) {
 PJDatePicker *datePicker = (PJDatePicker *)definition;
 } else if (class == [PJDescription class]) {
 PJDescription *descriptionField = (PJDescription *)definition;
 } else if (class == [PJListField class]) {
 PJListField *listField = (PJListField *)definition;
 } else if (class == [PJSubmitCell class]) {
 PJSubmitCell *submitCell = (PJSubmitCell *)definition;
 } else {
 }
 }
 */
@end
