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
@optional
- (void)submitAction:(id)sender;
@end

@interface FieldTableViewCell : UITableViewCell

//These are the common properties in every Field
@property (nonatomic) NSString    *titleText;
@property (nonatomic) NSString    *key;
@property (nonatomic) id          defaultValue;
@property (nonatomic) id          value;

@property (nonatomic) BOOL        isRequired;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) BOOL        isValid;
@property (nonatomic) NSString    *validityMessage;

@property (nonatomic,weak) id <FieldTableViewCell> delegate;

- (void)addBorders;
- (void)setUp;


@end
