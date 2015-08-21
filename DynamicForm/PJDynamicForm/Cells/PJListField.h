//
//  PJListField.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/21/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FieldTableViewCell.h"
#import "PJListViewController.h"

@interface PJListField : FieldTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *selectedValue;
@property (weak, nonatomic) IBOutlet UILabel *requiredLabel;

@end
