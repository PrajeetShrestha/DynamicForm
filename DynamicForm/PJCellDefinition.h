//
//  PJCellDefinition.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/20/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PJCellDefinition : NSObject
@property (nonatomic) NSString *type;

@property (nonatomic) id defaultValue;
@property (nonatomic) id value;

@property (nonatomic) NSDate   *createdTime;
@property (nonatomic) NSString *placeholder;
@property (nonatomic) NSString *title;

@property (nonatomic) BOOL isEnabled;
@property (nonatomic) BOOL isRequired;
@property (nonatomic) BOOL isVisible;

@end
