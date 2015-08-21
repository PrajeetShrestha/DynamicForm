//
//  FieldTableView.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "FieldTableView.h"
@implementation FieldTableView


- (void)awakeFromNib {
    [self registerNib:[UINib nibWithNibName:kPJTextField bundle:nil] forCellReuseIdentifier:kPJTextField];
    [self registerNib:[UINib nibWithNibName:kPJDescription bundle:nil] forCellReuseIdentifier:kPJDescription];
    [self registerNib:[UINib nibWithNibName:kPJDatePicker bundle:nil] forCellReuseIdentifier:kPJDatePicker];
    [self registerNib:[UINib nibWithNibName:kPJBoolField bundle:nil] forCellReuseIdentifier:kPJBoolField];
    [self registerNib:[UINib nibWithNibName:kPJListField bundle:nil] forCellReuseIdentifier:kPJListField];
    [self registerNib:[UINib nibWithNibName:kPJSubmitCell bundle:nil] forCellReuseIdentifier:kPJSubmitCell];
}

@end

