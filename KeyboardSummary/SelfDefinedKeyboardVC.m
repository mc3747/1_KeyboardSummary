//
//  SelfDefinedKeyboardVC.m
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "SelfDefinedKeyboardVC.h"
#import "SafeKeyBoardField.h"

#import "MCNumberKeyboardTextField.h"
#import "MCPasswordKeyboardTextView.h"
#import "IQKeyboardReturnKeyHandler.h"



@interface SelfDefinedKeyboardVC ()

@property (weak, nonatomic) IBOutlet MCNumberKeyboardTextField *textField2;
@property (weak, nonatomic) IBOutlet MCNumberKeyboardTextField *textField3;
@property (weak, nonatomic) IBOutlet MCNumberKeyboardTextField *textField4;
@property (weak, nonatomic) IBOutlet MCNumberKeyboardTextField *textField5;
@property (weak, nonatomic) IBOutlet MCNumberKeyboardTextField *textField6;
@property (weak, nonatomic) IBOutlet MCNumberKeyboardTextField *textField7;

@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;



@end

@implementation SelfDefinedKeyboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义数字安全键盘";
    self.view.backgroundColor = [UIColor redColor];
    
     [_textField2 setTextFieldStyle:MCNumberKeyboardStylePhone inView:self.view];
     [_textField3 setTextFieldStyle:MCNumberKeyboardStyleBankCard inView:self.view];
     _textField3.returnBlock = ^(MCNumberKeyboardTextField *textField, NSString *inputString, NSString *displayString) {
        NSLog(@"inputString:%@",inputString);
        NSLog(@"displayString:%@",displayString);
    };
     [_textField4 setTextFieldStyle:MCNumberKeyboardStyleIdentityCard inView:self.view];
     [_textField5 setTextFieldStyle:MCNumberKeyboardStyleInputWithoutDot inView:self.view];
     [_textField6 setTextFieldStyle:MCNumberKeyboardStyleInputWithDot inView:self.view];
     [_textField7 setTextFieldStyle:MCNumberKeyboardStyleRandomInputWithoutDot inView:self.view];
    
    
}



@end
