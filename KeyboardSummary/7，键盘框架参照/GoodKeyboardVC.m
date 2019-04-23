//
//  ViewController.m
//  BSYKeyboard
//
//  Created by 白仕云 on 2018/5/28.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import "GoodKeyboardVC.h"
#import "BSYTextFiled.h"
@interface GoodKeyboardVC ()
@property (nonatomic ,strong)BSYTextFiled *textField;
@end

@implementation GoodKeyboardVC

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = COMMON_GREY_COLOR;
    
    //身份者键盘
    self.textField = [[BSYTextFiled alloc] initWithFrame:CGRectMake(100, 100, 200, 40) showKeyBoardType:BSYIDCardType];
    self.textField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.textField];

    //手机号键盘
    BSYTextFiled *textField = [[BSYTextFiled alloc] initWithFrame:CGRectMake(100, 200, 200, 40) showKeyBoardType:BSYPhoneNumberType];
    textField.backgroundColor = [UIColor greenColor];
    [self.view addSubview:textField];

     //支付键盘
    BSYTextFiled *textField1 = [[BSYTextFiled alloc] initWithFrame:CGRectMake(100, 300, 200, 40) showKeyBoardType:BSYPayType];
    textField1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:textField1];

    //密码键盘
    BSYTextFiled *textField2 = [[BSYTextFiled alloc] initWithFrame:CGRectMake(100, 400, 200, 40) showKeyBoardType:BSYPassWordType];
    textField2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:textField2];

    //系统键盘
    BSYTextFiled *textField3 = [[BSYTextFiled alloc] initWithFrame:CGRectMake(100, 500, 200, 40) showKeyBoardType:BSYBoardTypeNone];
    textField3.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:textField3];

}
@end
