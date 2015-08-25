//
//  DescriptionViewController.m
//  DynamicForm
//
//  Created by Prajeet Shrestha on 8/20/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController ()

@end

@implementation DescriptionViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [self initWithNibName:@"DescriptionViewController" bundle:[NSBundle mainBundle]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.initialValue != nil) {
    self.textView.text      = self.initialValue;
    }
    self.textView.textColor = PJColorFieldValue;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.delegate passValue:self.textView.text forIndexPath:self.indexPath ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
