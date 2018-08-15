//
//  NewNumberKeyboarcVC.m
//  KeyboardSummary
//
//  Created by gjfax on 2018/8/15.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "NewNumberKeyboarcVC.h"
#import "MCNewNumberKeyboardTextField.h"

@interface NewNumberKeyboarcVC ()

@end

@implementation NewNumberKeyboarcVC

- (void)viewDidLoad {
    [super viewDidLoad];
    MCNewNumberKeyboardTextField *textField1 = [[MCNewNumberKeyboardTextField alloc] initWithFrame:CGRectMake(50, 100, 200, 50) andStyle:NumberTextFieldStyleInputWithDot];
    [textField1 shouldChangeNumbers:^(MCNewNumberKeyboardTextField *textField, NSString *inputString, NSString *displayString) {
        NSLog(@"输入值：%@",inputString);
        NSLog(@"显示值：%@",displayString);
    }];
    [self.view addSubview:textField1];
}




@end
