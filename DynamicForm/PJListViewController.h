//
//  PJListViewController.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/21/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PJListViewControllerDelegate <NSObject>
- (void)selectedItemInList:(id)value;
@end
@interface PJListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) id <PJListViewControllerDelegate> delegate;
@property (nonatomic) NSArray *dataArray;

@end
