//
//  MCNumberKeyboardTextField.m
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/9.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "MCNumberKeyboardTextField.h"
#import "MCNumberKeyboardMethod.h"
#import "UIView+Extension.h"
#import "MCNumberKeyboardView.h"

@interface MCNumberKeyboardTextField ()
@property (nonatomic, strong) UIView *curView;
@property (nonatomic, strong) MCNumberKeyboardView          *keyBoardView;
@property (nonatomic, assign) MCNumberKeyboardStyle         mcKeyboardStyle;
@property (nonatomic, assign) NumberKeyboardStyle           keyboardStyle;
@property (nonatomic, copy) NSString *textContent;
@end



@implementation MCNumberKeyboardTextField
#pragma mark -  初始化
- (instancetype)initWithFrame:(CGRect)frame andStyle:(MCNumberKeyboardStyle )mcKeyboardStyle inView:(UIView *)curView{
    
    self = [super initWithFrame:frame];
    if (self) {

        [self baseConfigWith:mcKeyboardStyle andView:curView];
    };
    return self;
}

#pragma mark -  相关设置
- (void)setTextFieldStyle:(MCNumberKeyboardStyle)mcKeyboardStyle inView:(UIView *)curView {
    
    if (!_keyBoardView) {
       
        [self baseConfigWith:mcKeyboardStyle andView:curView];
    };
    
}

#pragma mark -  基础配置
- (void)baseConfigWith:(MCNumberKeyboardStyle)mcKeyboardStyle andView:(UIView *)curView  {
    
    if (!curView || ![curView isKindOfClass:[UIView class]]) {
        return;
    };
    
    // 类型和附属view属性
    self.mcKeyboardStyle = mcKeyboardStyle;
    self.curView = curView;
    
    // 数字键盘类型转换
    [self convertTextfieldToKeyboard];
    
    // textField的配置
    [self configTextField];
    
    // 数字键盘的配置
    [self configNumberKeyboard];
    
}

#pragma mark - textField类型转成keyboard类型
- (void)convertTextfieldToKeyboard {
    
  if (MCNumberKeyboardStyleIdentityCard == _mcKeyboardStyle ) {
      _keyboardStyle = NumberKeyboardStyleOrderX;
        
    }else if (MCNumberKeyboardStyleInputWithDot == _mcKeyboardStyle) {
        _keyboardStyle = NumberKeyboardStyleOrderPoint;
        
    }else {
         _keyboardStyle = NumberKeyboardStyleOrderDelete;
    };
}

#pragma mark - textfield相关的设置
- (void )configTextField {
    [self setPlaceholder:@"请输入密码"];
    [self addTarget:self action:@selector(removeFocus) forControlEvents:UIControlEventEditingDidEnd];
    [self addTarget:self action:@selector(recoveryFocus) forControlEvents:UIControlEventEditingDidBegin];
}

#pragma mark -  数字键盘配置
- (void)configNumberKeyboard{
    __weak typeof(self) weakSelf = self;
    // 置空内容
    self.textContent = @"";
    
    // textField的初始化
    self.keyBoardView = [self getSelfDefineKeyBoardViewWithStyle:_keyboardStyle];
    
    // textField的点击回调
    self.keyBoardView.returnBlock = ^(NSString *textString, ReturnBlockType type) {
            // 删除一位
        if (ReturnBlockTypeClearOne == type) {
            if (weakSelf.textContent.length > 0) {
                weakSelf.textContent = [weakSelf.textContent substringToIndex:weakSelf.text.length - 1];
            }
            weakSelf.text = weakSelf.textContent;
            [weakSelf monitorTextLength:weakSelf.textContent];

            // 删除全部
        }else if (ReturnBlockTypeClearAll == type) {
            weakSelf.textContent = @"";
            weakSelf.text = weakSelf.textContent;
            [weakSelf monitorTextLength:weakSelf.textContent];

            //数字或者点或者X输入
        }else if (ReturnBlockTypeDefuatl == type ) {
            weakSelf.textContent = [weakSelf.textContent stringByAppendingString:textString];
            
            [weakSelf monitorTextFieldInput:weakSelf.textContent];
        };
        
            //整个回调监听
        [weakSelf monitorTextField];
    };
    
    // 基础view的点击完成箭头回调
    self.keyBoardView.finishBlock = ^{
        [weakSelf resignFirstResponder];
    };

}
- (void)monitorTextField {
    NSString *inputString = [self.textContent stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (self.returnBlock) {
        self.returnBlock(self, inputString, self.textContent);
    };
}
#pragma mark - 获取焦点
- (void)recoveryFocus {
    
    self.inputView = self.keyBoardView;
    self.inputAccessoryView = [[UIView alloc] init];
}

#pragma mark - 失去焦点
- (void)removeFocus {
//    [self.keyBoardView downInView];
    [self resignFirstResponder];
}

#pragma mark -  编辑内容
- (void)monitorTextLength:(NSString *)text {
    
    if (text.length == 20 && MCNumberKeyboardStyleIdentityCard == _mcKeyboardStyle ) {
        [self.keyBoardView activeButtonX];
        
    } else if(![text containsString:@"."] && MCNumberKeyboardStyleInputWithDot == _mcKeyboardStyle ) {
        [self.keyBoardView activeButtonX];
        
    } else {
        [self.keyBoardView nonActiveButtonX];
    };
}

#pragma mark - 监听textField的输入
- (void)monitorTextFieldInput:(NSString *)textString {
    
    self.text = textString;
    
    if (MCNumberKeyboardStylePhone == _mcKeyboardStyle) {
        // 手机号码
        [MCNumberKeyboardMethod formatToPhone:self andString:textString];
        
    } else if (MCNumberKeyboardStyleBankCard == _mcKeyboardStyle) {
        // 银行卡
        [MCNumberKeyboardMethod formatToBankCard:self andString:textString];
        
    } else if (MCNumberKeyboardStyleIdentityCard == _mcKeyboardStyle) {
        // 身份证
        [MCNumberKeyboardMethod formatToIdentityCard:self andString:textString];
        [self monitorTextLength:textString];
        
    } else if (MCNumberKeyboardStyleInputWithoutDot == _mcKeyboardStyle ) {
        // 输入整数金额
        [MCNumberKeyboardMethod formatToInputAmount:self andString:textString andMaxLength:10];
        [self monitorTextLength:textString];
        
    }else if (MCNumberKeyboardStyleInputWithDot == _mcKeyboardStyle) {
        // 输入小数金额
        [MCNumberKeyboardMethod formatToInputAmount:self andString:textString andMaxLength:13];
        [self monitorTextLength:textString];
        
    }else if (MCNumberKeyboardStyleRandomInputWithoutDot == _mcKeyboardStyle ) {
        // 输入交易密码
        [MCNumberKeyboardMethod formatToInputAmount:self andString:textString andMaxLength:23];
        [self monitorTextLength:textString];
    };
    
    self.textContent = self.text;
    
}

#pragma mark - 退出键盘
- (void)keyBoardResignFirstResponder {
    [self.keyBoardView downInView];
}

#pragma mark - 弹出键盘
- (void)keyBoardBecomeFirstResponder {
    [self.keyBoardView showInView:_curView];
}

#pragma mark -  监听方法
- (void)shouldChangeNumbers:(MCNumberKeyboardBlock )returnBlock {
    _returnBlock = returnBlock;
}

#pragma mark - 自定义键盘view
- (MCNumberKeyboardView *)getSelfDefineKeyBoardViewWithStyle:(NumberKeyboardStyle)numberKeyboardStyle {
    
    if (!_keyBoardView) {
        
        _keyBoardView = [[MCNumberKeyboardView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT - 216 - 39 - IPHONE_X_Bottom_SafeArea_Height, MAIN_SCREEN_WIDTH, 216 + 39 + IPHONE_X_Bottom_SafeArea_Height) andStyle:numberKeyboardStyle];
    }
    return _keyBoardView;
}
@end
