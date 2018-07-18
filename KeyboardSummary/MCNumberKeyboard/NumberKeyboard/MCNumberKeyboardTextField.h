//
//  MCNumberKeyboardTextField.h
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/9.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCNumberKeyboardTextField;
/*数字键盘类型 */
typedef NS_ENUM(NSInteger, MCNumberKeyboardStyle) {
    MCNumberKeyboardStylePhone                    = 10001,         //手机号码（数字 + 全部删除）
    MCNumberKeyboardStyleBankCard                 = 10002,         //银行卡号（数字 + 全部删除）
    MCNumberKeyboardStyleIdentityCard             = 10003,         //身份证号（数字 + X）
    MCNumberKeyboardStyleInputWithoutDot          = 10004,         //输入整数金额（数字 + 全部删除）
    MCNumberKeyboardStyleInputWithDot             = 10005,         //输入小数金额（数字 + 小数点）
    MCNumberKeyboardStyleRandomInputWithoutDot    = 10006,         //输入交易密码，键盘数字打乱（数字 + 全部删除）
};

/**  键盘输入值变化block：textField，输入值，显示值*/
typedef void(^MCNumberKeyboardBlock)(MCNumberKeyboardTextField *textField, NSString *inputString,NSString *displayString);

@interface MCNumberKeyboardTextField : UITextField

/**1，初始化：已知尺寸，可以设置改属性  */
- (void)setTextFieldStyle:(MCNumberKeyboardStyle)mcKeyboardStyle inView:(UIView *)curView;

/**2，未知尺寸，统一初始化*/
- (instancetype)initWithFrame:(CGRect)frame andStyle:(MCNumberKeyboardStyle )mcKeyboardStyle inView:(UIView *)curView;


/**1，属性监听输入*/
@property (nonatomic, copy) MCNumberKeyboardBlock   returnBlock;

/**2，方法监听*/
- (void)shouldChangeNumbers:(MCNumberKeyboardBlock )returnBlock;


/**  退出键盘*/
- (void)keyBoardResignFirstResponder;

/**  调出键盘*/
- (void)keyBoardBecomeFirstResponder;

@end
