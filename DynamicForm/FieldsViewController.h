//
//  FieldsViewController.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//
#import "PJConstants.h"
#import <UIKit/UIKit.h>

@interface FieldsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *cellDefinition;


@end
