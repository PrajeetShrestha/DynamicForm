//
//  FieldTableViewCell.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "FieldTableViewCell.h"

@implementation FieldTableViewCell

- (void)awakeFromNib {

}

- (void)layoutSubviews {
    self.validityMessage = @"Not Available";
    self.value = @"";
    self.isValid = NO;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)addBorders {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         static UIView *view = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            view = [UIView new];
            view.frame = self.bounds;
            view.frame = CGRectMake(self.bounds.origin.x, self.bounds.size.height-2,self.bounds.size.width, 1);
            view.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self.contentView addSubview:view];
        });
    });
}

@end
