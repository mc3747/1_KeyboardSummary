//
//  PasswordKeyboardVCViewController.m
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/16.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "PasswordKeyboardVC.h"
#import "PasswordKeyboardView.h"
#import "IQKeyboardManager.h"
#import "MCPasswordKeyboardTextView.h"

@interface PasswordKeyboardVC ()

@end

@implementation PasswordKeyboardVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //TODO: 页面appear 禁用
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //TODO: 页面Disappear 启用
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    PasswordKeyboardView *view= [[PasswordKeyboardView alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    view.endEditingOnFinished = YES;
    view.secureTextEntry = YES;
    view.payBlock = ^(NSString *payCode) {
        NSLog(@"view1输入密码是%@",payCode);
    };
    [self.view addSubview:view];
    
    MCPasswordKeyboardTextView *view2 = [[MCPasswordKeyboardTextView alloc] initWithFrame:CGRectMake(100, 180, 200, 50)];
    [view2 setCurrentView:self.view];
    [view2 shouldChangeNumbers:^(MCPasswordKeyboardTextView *textView, NSString *inputString, BOOL isClick) {
        NSLog(@"view2输入密码是%@",inputString);
    }];
    [self.view addSubview:view2];
}



@end
