//
//  PJListViewController.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/21/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//
#import "PJConstants.h"
#import "PJListViewController.h"
#import "PJListItemCell.h"

@interface PJListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PJListViewController
static NSString *cellIdentifier = @"PJListItemCell";
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [self initWithNibName:@"PJListViewController" bundle:[NSBundle mainBundle]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.hidesBackButton = YES;
    self.title = self.titleString;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listItems.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate selectedItemInList:self.listItems[indexPath.row] forCellAtIndexPath:self.indexPath andSelectedIndex:indexPath] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PJListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = self.listItems[indexPath.row];
    cell.textLabel.textColor = PJColorFieldValue;
    if ([indexPath isEqual: self.indexPathOfSelectedItem]) {
        cell.selectionIndicatorView.hidden = NO;
    } else {
        cell.selectionIndicatorView.hidden = YES;
    }
    //cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

@end
