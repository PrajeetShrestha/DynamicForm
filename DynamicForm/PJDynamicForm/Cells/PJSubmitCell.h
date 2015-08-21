//
//  PJSubmitCell.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/21/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FieldTableViewCell.h"

@interface PJSubmitCell :FieldTableViewCell

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitAction:(id)sender;
@end
