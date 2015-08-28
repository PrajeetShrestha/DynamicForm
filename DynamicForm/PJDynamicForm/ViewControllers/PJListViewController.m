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
@property (weak, nonatomic) IBOutlet UIButton *btnClearAll;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectAll;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintButtons;
@end

@implementation PJListViewController
static NSString *cellIdentifier = @"PJListItemCell";
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [self initWithNibName:@"PJListViewController" bundle:[NSBundle mainBundle]];
        self.allIndexPaths = [NSMutableArray new];
        if (self.userSelectedRows == nil) {
            self.userSelectedRows = [NSMutableArray new];
        }

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
        [self.btnClearAll setTitleColor:PJColorFieldValue forState:UIControlStateNormal];
        [self.btnSelectAll setTitleColor:PJColorFieldTitle forState:UIControlStateNormal];
    }

}
#pragma mark - Bar Button Action
- (void) done:(id)sender {
    [self.delegate selectedValuesFromList:self.userSelectedRows fromIndexPath:self.indexPath];
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listItems.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *row = [NSNumber numberWithInteger:indexPath.row];
    if (![self.userSelectedRows containsObject:row]) {
        [self.userSelectedRows addObject:row];
    }
    PJListItemCell *cell               = (PJListItemCell *)[tableView cellForRowAtIndexPath:indexPath];

    cell.selectionIndicatorView.hidden = NO;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *row = [NSNumber numberWithInteger:indexPath.row];
    if ([self.userSelectedRows containsObject:row]) {
        [self.userSelectedRows removeObject:row];
    }
    PJListItemCell *cell               = (PJListItemCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectionIndicatorView.hidden = YES;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PJListItemCell *cell     = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text      = self.listItems[indexPath.row];
    cell.textLabel.textColor = PJColorFieldValue;
    NSNumber *row = [NSNumber numberWithInteger:indexPath.row];
    if ([self.userSelectedRows containsObject:row]) {
        
        cell.selectionIndicatorView.hidden = NO;

        [tableView selectRowAtIndexPath:indexPath
                               animated:NO
                         scrollPosition:UITableViewScrollPositionNone];
    } else {
        cell.selectionIndicatorView.hidden   = YES;
    }

    return cell;
}

- (IBAction)clearAction:(id)sender {
    [self.userSelectedRows removeAllObjects];
    for (NSInteger i = 0; i < self.listItems.count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        PJListItemCell *cell = (PJListItemCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.selectionIndicatorView.hidden = YES;
    }
}

- (IBAction)selectAllAction:(id)sender {
    //Clear previous selection
    [self.userSelectedRows removeAllObjects];
    for (NSInteger i = 0; i < self.listItems.count; i ++) {
        NSNumber *row = [NSNumber numberWithInteger:i];
        [self.userSelectedRows addObject:row];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        PJListItemCell *cell = (PJListItemCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.selectionIndicatorView.hidden = NO;
    }
}


@end
