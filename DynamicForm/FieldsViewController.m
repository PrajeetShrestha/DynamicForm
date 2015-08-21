//
//  FieldsViewController.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "DescriptionViewController.h"
#import "FieldsViewController.h"
#import "FieldTableViewCell.h"

@interface FieldsViewController ()<FieldTableViewCell,DescriptionViewControllerDelegate> {

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
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect rectInSuperview = [tableView convertRect:rectInTableView toView:[tableView superview]];

    NSLog(@"%@ RECT IN SUPERVIEW " ,NSStringFromCGRect(rectInSuperview));
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
    PJCellDefinition *definition = cellDefinition[indexPath.row];
    NSString *cellType = definition.type;
    FieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
    cell.delegate = self;
    cell.value = definition.value;
    cell.isRequired = definition.isRequired;
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - FieldTableViewCellDelegate
- (void)didSelected:(Class)viewController sender:(FieldTableViewCell *)cell {
    DescriptionViewController *vc = [[viewController alloc]init];
    vc.delegate = self;
    vc.initialValue = cell.value;
    vc.indexPath = cell.indexPath;
    [self showViewController:vc sender:nil];
}

- (void)controlActivated:(id)sender {
    //FieldTableViewCell *cell = (FieldTableViewCell *)sender;
    //TODO: Future upgrade
    //Dynamic Form view scroll.
    //CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:cell.indexPath];
    //CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
    //NSLog(@"%@ RECT IN SUPERVIEW " ,NSStringFromCGRect(rectInSuperview));
}

- (void)controlValueChanged:(id)value sender:(FieldTableViewCell *)cell {
    PJCellDefinition *definition = cellDefinition[cell.indexPath.row];
    definition.value = value;

}
#pragma mark - DescriptionViewControllerDelegate
- (void)passValue:(id)value forIndexPath:(NSIndexPath *)indexPath {
    PJCellDefinition *definition = cellDefinition[indexPath.row];
    [self.tableView reloadData];
    definition.value = value;
}



@end
