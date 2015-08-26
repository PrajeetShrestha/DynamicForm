//
//  FormValues.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/26/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormValues : NSObject
@property (nonatomic) NSString *key;
@property (nonatomic) NSString *value;
@property (nonatomic) NSString *validityMessage;
@property (nonatomic) BOOL isValid;

@end
