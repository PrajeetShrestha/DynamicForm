//
//  PJBoolField.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "FieldTableViewCell.h"

@interface PJBoolField : FieldTableViewCell
@property (nonatomic) id valueWhenOn;
@property (nonatomic) id valueWhenOff;
@property (nonatomic) NSString *textValue;
@end
