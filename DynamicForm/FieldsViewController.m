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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self cellTypeForIndexPath:indexPath forTableView:tableView];
    return cell;
}

#pragma mark - TableView Delegates


#pragma mark - Private Method
- (UITableViewCell *)cellTypeForIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView *)tableView {
    PJCellDefinition *definition = cellDefinition[indexPath.row];
    NSString *cellType = definition.type;
    FieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
    cell.value = definition.value;
    cell.delegate = self;
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

- (void)controlValueChanged:(id)value sender:(FieldTableViewCell *)cell {
    PJCellDefinition *definition = cellDefinition[cell.indexPath.row];
    definition.value = value;

    NSLog(@"%@",[cellDefinition[cell.indexPath.row] valueForKey:@"value"]);
}
#pragma mark - DescriptionViewControllerDelegate
- (void)passValue:(id)value forIndexPath:(NSIndexPath *)indexPath {
    PJCellDefinition *definition = cellDefinition[indexPath.row];
    definition.value = value;
    [self.tableView reloadData];
}



@end
