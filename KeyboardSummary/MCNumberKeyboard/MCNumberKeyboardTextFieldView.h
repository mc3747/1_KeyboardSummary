//
//  GJSNumKeyBoardField.h
//  HX_GJS
//
//  Created by gjfax on 16/2/22.
//  Copyright © 2016年 GjFax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCNumberKeyboardView.h"

/*数字键盘类型 */
typedef NS_ENUM(NSInteger, NumberTextFieldStyle) {
    NumberTextFieldStylePassord          = 10000,         //数字交易密码
    NumberTextFieldStylePhone            = 10001,         //手机号码
    NumberTextFieldStyleBankCard         = 10002,         //银行卡号
    NumberTextFieldStyleIdentityCard     = 10003,         //身份证号
    NumberTextFieldStyleInputWithoutDot  = 10004,         //输入金额（不带小数点）
    NumberTextFieldStyleInputWithDot     = 10005          //输入金额（带小数点）
};

/**  回调字符串长度*/
typedef void(^returnTextNumberBlock)(NSInteger textNum);

@interface MCNumberKeyboardTextFieldView : UIView


/**  keyBoard Text*/
@property (nonatomic, strong) NSString              *text;

/**  回调block*/
@property (nonatomic, copy)   returnTextNumberBlock     block;

/**  默认初始化：*/
- (instancetype)initWithFrame:(CGRect)frame curView:(UIView *)curView;

/**  自定义初始化*/
- (instancetype)initWithFrame:(CGRect)frame  curView:(UIView *)curView andStyle:(NumberTextFieldStyle )textFieldStyle;

/*   已知尺寸后的初始化 */
- (void)setTextFieldStyle:(NumberTextFieldStyle)textFieldStyle inView:(UIView *)curView;

/**  实时监听输入数量回调*/
- (void)returnTextNumberBlcok:(returnTextNumberBlock)block;

/**  重置*/
- (void)resetKeyBoardText;

/**  退出键盘*/
- (void)keyBoardResignFirstResponder;

/**  调出键盘*/
- (void)keyBoardBecomeFirstResponder;
@end
