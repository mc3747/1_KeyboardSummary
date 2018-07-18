//
//  SelfDefinedSystemKeyboardVC.m
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/17.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "SelfDefinedSystemKeyboardVC.h"
#import "ChineseKeyboardTextField.h"

@interface SelfDefinedSystemKeyboardVC ()
@property (weak, nonatomic) IBOutlet ChineseKeyboardTextField *textField1;

@end

@implementation SelfDefinedSystemKeyboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [_textField1 configChineseKeyboard];
}



@end
