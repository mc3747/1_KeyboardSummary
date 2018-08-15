//
//  MCNewNumberKeyboardTextField.h
//  KeyboardSummary
//
//  Created by gjfax on 2018/8/14.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCNewNumberKeyboardTextField;

/*数字键盘类型 */
typedef NS_ENUM(NSInteger, NumberTextFieldStyle) {
    NumberTextFieldStyleDefault                  = 10000,         //默认（数字）
    NumberTextFieldStylePhone                    = 10001,         //手机号码（数字 + 全部删除）
    NumberTextFieldStyleBankCard                 = 10002,         //银行卡号（数字 + 全部删除）
    NumberTextFieldStyleIdentityCard             = 10003,         //身份证号（数字 + X）
    NumberTextFieldStyleInputWithoutDot          = 10004,         //输入整数金额（数字 + 全部删除）
    NumberTextFieldStyleInputWithDot             = 10005,         //输入小数金额（数字 + 小数点）
    NumberTextFieldStyleRandomInputWithoutDot    = 10006,         //输入交易密码，键盘数字打乱（数字 + 全部删除）
};

/**  键盘输入值变化block：textField，输入值，显示值*/
typedef void(^NumberTextFieldBlock)(MCNewNumberKeyboardTextField *textField, NSString *inputString,NSString *displayString);

@interface MCNewNumberKeyboardTextField : UITextField

/** 回调属性 */
@property (nonatomic, copy) NumberTextFieldBlock     returnBlock;

/** 是否隐藏顶部辅助视图 默认 NO，即不隐藏*/
@property (nonatomic, assign) BOOL                   isHiddenAccessoryView;

/** 键盘类型 */
@property (nonatomic, assign) NumberTextFieldStyle   textFieldStyle;

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame andStyle:(NumberTextFieldStyle )textFieldStyle;

//回调方法
- (void)shouldChangeNumbers:(NumberTextFieldBlock)returnBlock;

@end
