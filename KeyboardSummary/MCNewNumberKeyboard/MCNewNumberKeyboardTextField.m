//
//  MCNewNumberKeyboardTextField.m
//  KeyboardSummary
//
//  Created by gjfax on 2018/8/14.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "MCNewNumberKeyboardTextField.h"
#import "MCNewNumberKeyboardLayout.h"
#import "MCNumberKeyboardMethod.h"
#import "MCAccessoryLayout.h"
#import "UITextField+Judge.h"


/** 键盘主体高度 */
static CGFloat const kMainKeyboardHeight = 216;
/** 键盘顶部高度 */
static CGFloat const kAccessoryKeyboardHeight = 39;

@interface MCNewNumberKeyboardTextField()<UITextFieldDelegate>
@property (nonatomic, strong) MCAccessoryLayout         *accessoryLayout;
@property (nonatomic, strong) MCNewNumberKeyboardLayout *keyboardView;
@property (nonatomic, assign) NumberKeyboardStyle       keyboardStyle;
@property (nonatomic, assign) BOOL isNumberKeyboardOrder;
@property (nonatomic, copy) NSString *textContent;
@end

@implementation MCNewNumberKeyboardTextField
#pragma mark -  自定义初始化
- (instancetype)initWithFrame:(CGRect)frame andStyle:(NumberTextFieldStyle )textFieldStyle {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        _textFieldStyle = textFieldStyle;
        [self getViewCharacter:textFieldStyle];
        [self configTextField];
        [self configNumberKeyboard];
    };
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _keyboardStyle = NumberKeyboardStyleDefault;
        [self configTextField];
        [self configNumberKeyboard];
    };
    return self;
}

- (void)setTextFieldStyle:(NumberTextFieldStyle)textFieldStyle {
    [self getViewCharacter:textFieldStyle];
    [self configTextField];
    [self configNumberKeyboard];
}

#pragma mark -  获取view的相关特性
- (void)getViewCharacter:(NumberTextFieldStyle)textFieldStyle {
// 手机
    if (NumberTextFieldStylePhone == textFieldStyle) {
        _keyboardStyle = NumberKeyboardStyleDelete;
        _isNumberKeyboardOrder = YES;

// 银行卡
    }else if (NumberTextFieldStyleBankCard == textFieldStyle) {
        _keyboardStyle = NumberKeyboardStyleDelete;
        _isNumberKeyboardOrder = YES;
        
//身份证
    }else if (NumberTextFieldStyleIdentityCard == textFieldStyle) {
        _keyboardStyle = NumberKeyboardStyleX;
        _isNumberKeyboardOrder = YES;
        
//整数金额
    }else if (NumberTextFieldStyleInputWithoutDot == textFieldStyle) {
        _keyboardStyle = NumberKeyboardStyleDelete;
        _isNumberKeyboardOrder = YES;
        
//小数金额
    }else if (NumberTextFieldStyleInputWithDot == textFieldStyle) {
        _keyboardStyle = NumberKeyboardStylePoint;
        _isNumberKeyboardOrder = YES;
        
//交易密码
    }else if (NumberTextFieldStyleRandomInputWithoutDot == textFieldStyle) {
        _keyboardStyle = NumberKeyboardStyleDelete;
        _isNumberKeyboardOrder = NO;
        
//默认
    }else{
        _keyboardStyle = NumberKeyboardStyleDefault;
        _isNumberKeyboardOrder = YES;
    }
}

#pragma mark - textfield相关的设置
- (void )configTextField {
    [self setPlaceholder:@"请输入密码"];
    [self addTarget:self action:@selector(removeFocus) forControlEvents:UIControlEventEditingDidEnd];
    [self addTarget:self action:@selector(recoveryFocus) forControlEvents:UIControlEventEditingDidBegin];
}
// 获取焦点
- (void)recoveryFocus {
    self.inputAccessoryView = self.accessoryLayout;
    self.inputView = self.keyboardView;
}

// 失去焦点
- (void)removeFocus {
    [self resignFirstResponder];
}

#pragma mark -  数字键盘配置
- (void)configNumberKeyboard{
    __weak typeof(self) weakSelf = self;
// 置空内容
    self.textContent = @"";
    
// textField的初始化
    self.keyboardView = [self getSelfDefineKeyBoardViewWithStyle:_keyboardStyle];
    
// textField的点击数字回调
    //数字
    [self.keyboardView getClickNumberBlock:^(NSString *numberStr) {
        weakSelf.textContent = [weakSelf.textContent stringByAppendingString:numberStr];
        [weakSelf monitorTextFieldInput:weakSelf.textContent numberString:numberStr];
        [weakSelf monitorTextField];
    }];
    //小数点
    [self.keyboardView getClickDotBlock:^(NSString *numberStr) {
        weakSelf.textContent = [weakSelf.textContent stringByAppendingString:numberStr];
        [weakSelf monitorTextFieldInput:weakSelf.textContent numberString:numberStr];
        [weakSelf monitorTextField];
    }];
    //字符X
    [self.keyboardView getClickXBlock:^(NSString *numberStr) {
        weakSelf.textContent = [weakSelf.textContent stringByAppendingString:numberStr];
        [weakSelf monitorTextFieldInput:weakSelf.textContent numberString:numberStr];
        [weakSelf monitorTextField];
    }];
    //删除1位
    [self.keyboardView getClickDeleteBlock:^{
        if (weakSelf.textContent.length > 0) {
            weakSelf.textContent = [weakSelf.textContent substringToIndex:weakSelf.text.length - 1];
        }
        weakSelf.text = weakSelf.textContent;
        [weakSelf monitorTextLength:weakSelf.textContent];
        [weakSelf monitorTextField];
    }];
    //删除全部
    [self.keyboardView getClickTotalDeleteBlock:^{
        weakSelf.textContent = @"";
        weakSelf.text = weakSelf.textContent;
        [weakSelf monitorTextLength:weakSelf.textContent];
        [weakSelf monitorTextField];
    }];
}

#pragma mark -  回调输出
- (void)monitorTextField {
    NSString *inputString = [self.textContent stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (self.returnBlock) {
        self.returnBlock(self, inputString, self.textContent);
    };
}


#pragma mark - 监听textField的输入
- (void)monitorTextFieldInput:(NSString *)textString numberString:(NSString *)numberString{
    
    self.text = textString;
    
    if (NumberTextFieldStylePhone == _textFieldStyle) {
        // 手机号码
        [MCNumberKeyboardMethod formatToPhone:self andString:textString];
        
    } else if (NumberTextFieldStyleBankCard == _textFieldStyle) {
        // 银行卡
        [MCNumberKeyboardMethod formatToBankCard:self andString:textString];
        
    } else if (NumberTextFieldStyleIdentityCard == _textFieldStyle) {
        // 身份证
        [MCNumberKeyboardMethod formatToIdentityCard:self andString:textString];
        [self monitorTextLength:textString];
        
    } else if (NumberTextFieldStyleInputWithoutDot == _textFieldStyle ) {
        // 输入整数金额
        [MCNumberKeyboardMethod formatToInputAmount:self andString:textString andMaxLength:10];
        [self monitorTextLength:textString];
        [self monitorTextContent:textString and:numberString];
        
    }else if (NumberTextFieldStyleInputWithDot == _textFieldStyle) {
        // 输入小数金额
        [MCNumberKeyboardMethod formatToInputAmount:self andString:textString andMaxLength:13];
        [self monitorTextLength:textString];
        [self monitorTextContent:textString and:numberString];
        
    }else if (NumberTextFieldStyleRandomInputWithoutDot == _textFieldStyle ) {
        // 输入交易密码
        [MCNumberKeyboardMethod formatToInputAmount:self andString:textString andMaxLength:23];
        [self monitorTextLength:textString];
        
    } else {
        // 默认
        [MCNumberKeyboardMethod formatToInputAmount:self andString:textString andMaxLength:23];
    };
    
    self.textContent = self.text;
}

#pragma mark -  输入内容
- (void)monitorTextLength:(NSString *)text {
    
    if (text.length == 20 && NumberTextFieldStyleIdentityCard == _textFieldStyle ) {
        [self.keyboardView activeButtonX];
        
    } else if(![text containsString:@"."] && NumberTextFieldStyleInputWithDot == _textFieldStyle) {
        [self.keyboardView activeButtonX];
        
    } else {
        [self.keyboardView nonActiveButtonX];
    };
}
#pragma mark -  输入首位是否为0
/*限制条件：
 *  1，[第一位不允许输入小数点'.']
 *  2，[只允许出现一次小数点]
 *  3，[只支持输入小数点后2位]
 *  4，整数金额输入框，第一位不可输入为0
 *  5，小数金额输入框，第一位是0，第二位只能输入小数点
 */
- (void)monitorTextContent:(NSString *)textSring and:(NSString *)numberString {
    BOOL isValid = YES;
    NSRange range = NSMakeRange(textSring.length, 0);
    if (textSring.length > 0) {
        if ([numberString isEqualToString:@"0"] && range.location == 1 && (NumberTextFieldStyleInputWithoutDot == _textFieldStyle)) {
            isValid = NO;
            
        }else if ( (NumberTextFieldStyleInputWithDot == _textFieldStyle)) {
            if ([numberString isEqualToString:@"0"] && range.location == 1) {
                isValid = YES;
                [_keyboardView nonActiveNumberButton];
            }else {
                [_keyboardView activeNumberButton];
            };
            
        };
    };
     isValid = [self moneyInputJudge:textSring range:range];
    NSString *returnString = isValid?textSring:[textSring substringToIndex:textSring.length - 1];
    self.text = returnString;
}
#pragma mark - 回调方法
- (void)shouldChangeNumbers:(NumberTextFieldBlock)returnBlock {
    _returnBlock = returnBlock;
}
#pragma mark - 顶部提示layout
- (MCAccessoryLayout *)accessoryLayout
{
    if (!_accessoryLayout) {
        _accessoryLayout = [[MCAccessoryLayout alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kMainKeyboardHeight - kAccessoryKeyboardHeight - IPHONE_X_Bottom_SafeArea_Height, [UIScreen mainScreen].bounds.size.width, kAccessoryKeyboardHeight)];
        __weak typeof (self)weakSelf = self;
        // 收起键盘小图标
        [_accessoryLayout getAccessoryFinishClickBlock:^{
            [weakSelf removeFocus];
        }];
    }
    
    if (_isHiddenAccessoryView) {
        _accessoryLayout = nil;
    }
    return _accessoryLayout;
    
}
#pragma mark - 自定义键盘view
- (MCNewNumberKeyboardLayout *)getSelfDefineKeyBoardViewWithStyle:(NumberKeyboardStyle)numberKeyboardStyle {
    
    if (!_keyboardView) {
        _keyboardView = [[MCNewNumberKeyboardLayout alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT - kMainKeyboardHeight - IPHONE_X_Bottom_SafeArea_Height, MAIN_SCREEN_WIDTH, kMainKeyboardHeight + IPHONE_X_Bottom_SafeArea_Height) andStyle:_keyboardStyle andOrder:_isNumberKeyboardOrder];
    }
    return _keyboardView;
}
@end
