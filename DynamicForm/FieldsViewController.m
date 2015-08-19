//
//  FieldsViewController.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "FieldsViewController.h"
#import "FieldTableViewCell.h"

@interface FieldsViewController ()<FieldTableViewCell>

@end

@implementation FieldsViewController
@synthesize cellTypes;

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
    cellTypes = @[@0,@1,@2,@3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cellTypes.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self cellTypeForIndexPath:indexPath forTableView:tableView];
    return cell;
}

#pragma mark - TableView Delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - Private Method
- (UITableViewCell *)cellTypeForIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView *)tableView {
    FieldTableViewCell *cell;
    int cellType = [cellTypes[indexPath.row] intValue];
    switch (cellType) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"PJTextField"];
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"PJDescription"];
            cell.delegate = self;
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"PJBoolField"];
            break;
        case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"PJDatePicker"];
            break;
        default:
            cell = nil;
            break;
    }
    return cell;
}

- (void)didSelected {
    //[self showViewController:<#(UIViewController *)#> sender:<#(id)#>
}


@end
