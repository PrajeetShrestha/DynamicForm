//
//  PJBoolField.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "PJBoolField.h"
@interface PJBoolField ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;

@end

@implementation PJBoolField

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title.textColor = PJColorFieldTitle;
    self.title.font = [UIFont systemFontOfSize:PJSizeFieldTitle];
    self.switchControl.onTintColor = PJColorFieldTitle;
    self.switchControl.tintColor = PJColorFieldTitle;
    [self.switchControl addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];

}
#pragma mark - Selectors
- (void)setState:(UISwitch *)sender {
    if (sender.isOn) {
    self.value       = @YES;
    self.textValue   = self.valueWhenOn ;

    } else {

    self.value       = @NO;
    self.textValue   = self.valueWhenOff;
    }

    [self.delegate controlValueChanged:self];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [super addBorders];
    bool switchState = [self.value boolValue];
    self.title.text  = self.titleText;
    //Bool Field always have a default state so it's valid.
    self.isValid = YES;
    if (switchState) {
        [self.switchControl setOn:YES animated:NO];
        self.value       = @YES;
        self.textValue   = self.valueWhenOn;

    } else {
        [self.switchControl setOn:NO animated:NO];
        self.value       = @NO;
        self.textValue   = self.valueWhenOff;
    }
}



@end
