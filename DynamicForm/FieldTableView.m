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
    [self registerNib:[UINib nibWithNibName:@"PJTextField" bundle:nil] forCellReuseIdentifier:@"PJTextField"];
    [self registerNib:[UINib nibWithNibName:@"PJDescription" bundle:nil] forCellReuseIdentifier:@"PJDescription"];
    [self registerNib:[UINib nibWithNibName:@"PJDatePicker" bundle:nil] forCellReuseIdentifier:@"PJDatePicker"];
    [self registerNib:[UINib nibWithNibName:@"PJBoolField" bundle:nil] forCellReuseIdentifier:@"PJBoolField"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
