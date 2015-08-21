//
//  DescriptionViewController.h
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/20/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//
#import "PJConstants.h"
#import <UIKit/UIKit.h>

@protocol DescriptionViewControllerDelegate <NSObject>
- (void)passValue:(id)value forIndexPath:(NSIndexPath *)indexPath;
@end

@interface DescriptionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) NSString *initialValue;
@property (nonatomic,weak)id <DescriptionViewControllerDelegate> delegate;
@property (nonatomic) NSIndexPath *indexPath;
@end
