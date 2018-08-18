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
    MCNewNumberKeyboardTextField *textField1 = [[MCNewNumberKeyboardTextField alloc] initWithFrame:CGRectMake(20, 100, 300, 50) andStyle:NumberTextFieldStyleDefault];
    textField1.placeholder = @"1,默认";
    [textField1 shouldChangeNumbers:^(MCNewNumberKeyboardTextField *textField, NSString *inputString, NSString *displayString) {
        NSLog(@"输入值：%@",inputString);
        NSLog(@"显示值：%@",displayString);
    }];
    [self.view addSubview:textField1];
    
    MCNewNumberKeyboardTextField *textField2 = [[MCNewNumberKeyboardTextField alloc] initWithFrame:CGRectMake(20, 160, 300, 50) andStyle:NumberTextFieldStylePhone];
    textField2.placeholder = @"2,手机";
    [textField2 shouldChangeNumbers:^(MCNewNumberKeyboardTextField *textField, NSString *inputString, NSString *displayString) {
        NSLog(@"输入值：%@",inputString);
        NSLog(@"显示值：%@",displayString);
    }];
    [self.view addSubview:textField2];
    
    MCNewNumberKeyboardTextField *textField3 = [[MCNewNumberKeyboardTextField alloc] initWithFrame:CGRectMake(20, 220, 300, 50) andStyle:NumberTextFieldStyleBankCard];
    textField3.placeholder = @"3,银行卡";
    [textField3 shouldChangeNumbers:^(MCNewNumberKeyboardTextField *textField, NSString *inputString, NSString *displayString) {
        NSLog(@"输入值：%@",inputString);
        NSLog(@"显示值：%@",displayString);
    }];
    [self.view addSubview:textField3];
    
    MCNewNumberKeyboardTextField *textField4 = [[MCNewNumberKeyboardTextField alloc] initWithFrame:CGRectMake(20, 280, 300, 50) andStyle:NumberTextFieldStyleIdentityCard];
    textField4.placeholder = @"4,身份证";
    [textField4 shouldChangeNumbers:^(MCNewNumberKeyboardTextField *textField, NSString *inputString, NSString *displayString) {
        NSLog(@"输入值：%@",inputString);
        NSLog(@"显示值：%@",displayString);
    }];
    [self.view addSubview:textField4];
    
    MCNewNumberKeyboardTextField *textField5 = [[MCNewNumberKeyboardTextField alloc] initWithFrame:CGRectMake(20, 340, 300, 50) andStyle:NumberTextFieldStyleRandomInputWithoutDot];
    textField5.placeholder = @"5,整数";
    [textField5 shouldChangeNumbers:^(MCNewNumberKeyboardTextField *textField, NSString *inputString, NSString *displayString) {
        NSLog(@"输入值：%@",inputString);
        NSLog(@"显示值：%@",displayString);
    }];
    [self.view addSubview:textField5];
    
    MCNewNumberKeyboardTextField *textField6 = [[MCNewNumberKeyboardTextField alloc] initWithFrame:CGRectMake(20, 400, 300, 50) andStyle:NumberTextFieldStyleInputWithDot];
    textField6.placeholder = @"6,小数";
    [textField6 shouldChangeNumbers:^(MCNewNumberKeyboardTextField *textField, NSString *inputString, NSString *displayString) {
        NSLog(@"输入值：%@",inputString);
        NSLog(@"显示值：%@",displayString);
    }];
    [self.view addSubview:textField6];
    
    MCNewNumberKeyboardTextField *textField7 = [[MCNewNumberKeyboardTextField alloc] initWithFrame:CGRectMake(20, 460, 300, 50) andStyle:NumberTextFieldStyleRandomInputWithoutDot];
    textField7.placeholder = @"7,密码";
    [textField7 shouldChangeNumbers:^(MCNewNumberKeyboardTextField *textField, NSString *inputString, NSString *displayString) {
        NSLog(@"输入值：%@",inputString);
        NSLog(@"显示值：%@",displayString);
    }];
    [self.view addSubview:textField7];
    
}




@end
