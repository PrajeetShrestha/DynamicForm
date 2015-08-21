//
//  PJBoolField.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "PJBoolField.h"

@implementation PJBoolField

- (void)awakeFromNib {
    self.title.textColor = PJColorFieldTitle;
    self.title.font = [UIFont systemFontOfSize:PJSizeFieldTitle];
}

- (void)layoutSubviews {
    self.title.text = self.titleText;
}
@end
