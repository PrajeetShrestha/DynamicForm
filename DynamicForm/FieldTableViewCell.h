//
//  FieldTableViewCell.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//
#import "PJConstants.h"
#import <UIKit/UIKit.h>
@protocol FieldTableViewCell<NSObject>
- (void)controlActivated:(id)sender;
- (void)controlValueChanged:(id)value sender:(id)cell;
- (void)didSelected:(Class)viewController sender:(id)cell;
@end

@interface FieldTableViewCell : UITableViewCell
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *titleText;
@property (nonatomic) NSString *placeHolderText;
@property (nonatomic) id value;
//Array of String options
@property (nonatomic) NSArray *dataArray;
@property (nonatomic,weak) id <FieldTableViewCell> delegate;
@property (nonatomic) BOOL isRequired;

@end
