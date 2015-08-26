//
//  PJListViewController.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/21/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PJListViewControllerDelegate <NSObject>
//Selected Indexes because when called by a MultipleSelect list view indexes will be passed
- (void)selectedItemInList:(id)value forCellAtIndexPath:(NSIndexPath *)indexPath andSelectedIndex:(id )selectedIndexes;
@end
@interface PJListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) id <PJListViewControllerDelegate> delegate;
@property (nonatomic) NSArray *listItems;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) NSIndexPath *indexPathOfSelectedItem;
@property (nonatomic) NSString *titleString;
@property (nonatomic) PJListSelectionOption selectionOption;

@end
