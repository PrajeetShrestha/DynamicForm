//
//  FieldTableViewCell.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FieldTableViewCell<NSObject>
- (void)didSelected;
@end
@interface FieldTableViewCell : UITableViewCell
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *placeHolder;
@property (nonatomic) NSString *segueName;
@property (nonatomic) id value;
@property (nonatomic,weak) id <FieldTableViewCell> delegate;
@end
