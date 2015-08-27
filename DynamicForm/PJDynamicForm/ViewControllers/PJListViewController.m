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

@interface PJListViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic) NSMutableArray *allIndexPaths;
@end

@implementation PJListViewController
static NSString *cellIdentifier = @"PJListItemCell";
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [self initWithNibName:@"PJListViewController" bundle:[NSBundle mainBundle]];
        self.allIndexPaths = [NSMutableArray new];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.tableView.delegate             = self;
    self.tableView.dataSource           = self;
    self.navigationItem.hidesBackButton = YES;
    self.title                          = self.titleString;

    //Default will be PJListSingleSelection
    if (self.selectionOption == PJListSingleSelection) {
        self.tableView.allowsMultipleSelection = NO;
    } else if(self.selectionOption == PJListMultipleSelection) {
        self.tableView.allowsMultipleSelection = YES;
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
        self.navigationItem.rightBarButtonItem = doneButton;
    }

    for (int i = 0; i < self.listItems.count; i ++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.allIndexPaths addObject:indexpath];
    }
}
#pragma mark - Bar Button Action
- (void) done:(id)sender {
    //    [self.navigationController popViewControllerAnimated:NO];
    NSMutableArray *selectedItems = [NSMutableArray new];

    for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows) {
        [selectedItems addObject:self.listItems[indexPath.row]];
    }

    [self.delegate selectedItemInList:selectedItems forCellAtIndexPath:self.indexPath andSelectedIndex:self.tableView.indexPathsForSelectedRows] ;

    //FIXME: IF Animtation is set yes the app will crash
    [self.navigationController popViewControllerAnimated:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listItems.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectionOption == PJListMultipleSelection) {
        [self updateCells];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate selectedItemInList:self.listItems[indexPath.row] forCellAtIndexPath:self.indexPath andSelectedIndex:indexPath] ;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self updateCells];
}

- (void)updateCells {
    for (NSIndexPath *indexPath in self.allIndexPaths) {
        PJListItemCell *cell = (PJListItemCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if ([self.tableView.indexPathsForSelectedRows containsObject:indexPath]) {
            cell.selectionIndicatorView.hidden = NO;
        } else {
            cell.selectionIndicatorView.hidden = YES;
        }
    }
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

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollViews {
    [self updateCells]  ;
}




@end
