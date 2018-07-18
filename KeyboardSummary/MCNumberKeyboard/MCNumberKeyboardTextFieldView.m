//
//  GJSNumKeyBoardField.m
//  HX_GJS
//
//  Created by gjfax on 16/2/22.
//  Copyright © 2016年 GjFax. All rights reserved.
//

#import "MCNumberKeyboardTextFieldView.h"
#import "MCNumberKeyboardMethod.h"
#import "UIView+Extension.h"

static NSInteger kNum = 6;

@interface MCNumberKeyboardTextFieldView ()

@property (nonatomic, strong) MCNumberKeyboardView          *keyBoardView;
@property (nonatomic, assign) CGFloat                       gridWidth;  //每个格子的宽
@property (nonatomic, weak) UIView                          *curView;
@property (nonatomic, weak) UITextField                     *textField;
@property (nonatomic, assign) NumberTextFieldStyle          textFieldStyle;
@property (nonatomic, assign) NumberKeyboardStyle           keyboardStyle;
@end

@implementation MCNumberKeyboardTextFieldView

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GJS_KeyBoard_DownView_Noti object:nil];
    DLog(@"dealloc GJSNumKeyBoardField");
}

#pragma mark -  设置键盘类型
- (void)setTextFieldStyle:(NumberTextFieldStyle)textFieldStyle inView:(UIView *)curView{
    
    _textFieldStyle = textFieldStyle;
    
    // textField类型转成keyboard类型
    [self convertTextfieldToKeyboard];
    
    if ( NumberKeyboardStyleDisorder == _keyboardStyle ) {
        //圆圈键盘
        [self configBlackCircleKeyboard:curView];
        
    }else {
        //数字键盘
        [self configNumberKeyboard:curView];
    }
    
}

#pragma mark - 自定义初始化
- (instancetype)initWithFrame:(CGRect)frame  curView:(UIView *)curView andStyle:(NumberTextFieldStyle)textFieldStyle {
    
    _textFieldStyle = textFieldStyle;
    
    // textField类型转成keyboard类型
    [self convertTextfieldToKeyboard];
    
    if ( NumberKeyboardStyleDisorder == _keyboardStyle ) {
      return  [self initWithFrame:frame curView:curView];
        
    }else {
        self = [super initWithFrame:frame];
        if (self) {
            if (!curView || ![curView isKindOfClass:[UIView class]]) {
                return self;
            };
        };
        // 数字键盘的配置
        [self configNumberKeyboard:curView];
        return self;
    }
  
}
#pragma mark -  数字键盘配置
- (void)configNumberKeyboard:(UIView *)curView {
    __weak typeof(self) weakSelf = self;
    // 置空内容
    self.text = @"";
    // 基础view的点击回调
    self.keyBoardView = [self getSelfDefineKeyBoardViewWithStyle:_keyboardStyle];
    self.keyBoardView.returnBlock = ^(NSString *textString, ReturnBlockType type) {
        // 删除一位
        if (ReturnBlockTypeClearOne == type) {
            if (weakSelf.text.length > 0) {
                weakSelf.text = [weakSelf.text substringToIndex:weakSelf.text.length - 1];
            }
            weakSelf.textField.text = weakSelf.text;
            [weakSelf monitorTextLength:weakSelf.text];
            
            // 删除全部
        }else if (ReturnBlockTypeClearAll == type) {
            weakSelf.text = @"";
            weakSelf.textField.text = weakSelf.text;
            [weakSelf monitorTextLength:weakSelf.text];
            
            //数字或者点输入
        }else if (ReturnBlockTypeDefuatl == type ) {
            weakSelf.text = [weakSelf.text stringByAppendingString:textString];
            [weakSelf monitorTextFieldInput:weakSelf.text];
        };
        
        
    };
    // 基础view的点击完成箭头回调
    self.keyBoardView.finishBlock = ^{
        [weakSelf.textField resignFirstResponder];
    };
    // 基础view
    _textField = [self configBlankBaseView];
    
}
#pragma mark -  编辑内容
- (void)monitorTextLength:(NSString *)text {
    
    if (text.length == 20 && NumberTextFieldStyleIdentityCard == _textFieldStyle ) {
        [self.keyBoardView activeButtonX];
        
    } else if(![text containsString:@"."] && NumberTextFieldStyleInputWithDot == _textFieldStyle ) {
        [self.keyBoardView activeButtonX];
        
    } else {
        [self.keyBoardView nonActiveButtonX];
    };
}

#pragma mark - textField类型转成keyboard类型
- (void)convertTextfieldToKeyboard {
    if ( NumberTextFieldStylePassord == _textFieldStyle ) {
        _keyboardStyle = NumberKeyboardStyleDisorder;
        
    } else if (NumberTextFieldStylePhone == _textFieldStyle || NumberTextFieldStyleBankCard == _textFieldStyle) {
        _keyboardStyle = NumberKeyboardStyleOrderDelete;
        
    }else if (NumberTextFieldStyleIdentityCard == _textFieldStyle ) {
        _keyboardStyle = NumberKeyboardStyleOrderX;
        
    }else if (NumberTextFieldStyleInputWithoutDot == _textFieldStyle) {
         _keyboardStyle = NumberKeyboardStyleOrderDelete;
        
    }else if (NumberTextFieldStyleInputWithDot == _textFieldStyle) {
        _keyboardStyle = NumberKeyboardStyleOrderPoint;
    };
}

#pragma mark - 圆圈键盘初始化：交易密码输入框初始化
- (instancetype)initWithFrame:(CGRect)frame curView:(UIView *)curView {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        if (!curView || ![curView isKindOfClass:[UIView class]]) {
            return self;
        }
       
        // 键盘的配置
        [self configBlackCircleKeyboard :curView];
    }
    return self;
}

#pragma mark -  默认黑圈交易密码设置
- (void)configBlackCircleKeyboard :(UIView *)curView{
    _curView = curView;
    // 基础view
    UIView *baseView = [self configBaseView];
    __weak typeof(self) weakSelf = self;
    // 弹出键盘
    [baseView GJSHandleClick:^(UIView *view) {
        [weakSelf.keyBoardView showInView:curView];
    }];
    // 置空内容
    self.text = @"";
    // 基础view的点击回调
    self.keyBoardView = [self getDefaultKeyBoardView];
    self.keyBoardView.returnBlock = ^(NSString *textString, ReturnBlockType type) {
        //删除一位
        if (ReturnBlockTypeClearOne == type) {
            if (weakSelf.text.length > 0) {
                weakSelf.text = [weakSelf.text substringToIndex:weakSelf.text.length - 1];
            }
            [weakSelf initTextInputFlag:weakSelf.text];
            
            //全部删除
        }else if (ReturnBlockTypeClearAll == type) {
            weakSelf.text = @"";
            [weakSelf initTextInputFlag:weakSelf.text];
            
            //数字按钮
        }else if (weakSelf.text.length < kNum && type == ReturnBlockTypeDefuatl) {
            weakSelf.text = [weakSelf.text stringByAppendingString:textString];
            if (weakSelf.text.length <= 6) {
                [weakSelf initTextInputFlag:weakSelf.text];
            }
        }
    };
}

#pragma mark - 基础view
- (UIView *)configBaseView{
    //背景view
    UIView *baseView = [[UIView alloc] initWithFrame:self.bounds];
    baseView.layer.borderWidth = 1.f;
    baseView.layer.borderColor = COMMON_LIGHT_GREY_COLOR.CGColor;
    baseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:baseView];
    //竖线
    self.gridWidth = self.width/kNum;
    for (NSInteger i = 0; i < kNum - 1; i++) { //只需5条线
        CGFloat lineX = self.gridWidth*(i+1);
        UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(lineX - 1, 3, 1.f, self.height - 6)];
        sepLine.backgroundColor = COMMON_LIGHT_GREY_COLOR;
        [baseView addSubview:sepLine];
    }
    //黑圆圈
    for (NSInteger i = 0; i < kNum; i++) {
        CGFloat lineX = self.gridWidth*i + (self.gridWidth - 20)/2;
        CGFloat lineY = (self.height - 20)/2;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, 20, 20)];
        view.tag = 10000+i;
        view.backgroundColor = COMMON_BLACK_COLOR;
        view.layer.cornerRadius = 10;
        view.hidden = YES;
        [baseView addSubview:view];
    }
    return baseView;
}
#pragma mark - 键盘点击后，显示黑色圆圈
- (void)initTextInputFlag:(NSString *)text {
    
    NSInteger maxTag = 10005;
    NSInteger length = text.length;
    NSInteger curMaxTag = 10000+length;
    for (NSInteger i = 0; i < length; i++) {
        UIView *view = [self viewWithTag:10000+i];
        view.hidden = NO;
    }
    for (NSInteger i = 0; i <= maxTag - curMaxTag; i++) {
        UIView *view = [self viewWithTag:10005 - i];
        view.hidden = YES;
    }
    
    if (_block) {
        if (length == 6) {
                DLog(@"length %ld %@",length,text);
                _block(length);
        }else if (length > 0 && length < 6) {
                DLog(@"length2 %ld",length);
                _block(length);
        }
    }
    
    
}
#pragma mark - 不带黑色圆圈的textfield
- (UITextField *)configBlankBaseView {
    
    UITextField *textField = [[UITextField alloc] initWithFrame:self.bounds];
    [textField setPlaceholder:@"请输入密码"];
    [textField addTarget:self action:@selector(recoveryFocus) forControlEvents:UIControlEventEditingDidBegin];
    [textField setInputView:self.keyBoardView];
    [textField setInputAccessoryView:[[UIView alloc] init]];
    [self addSubview:textField];
    return textField;
}
#pragma mark - 获取焦点
- (void)recoveryFocus {
     [self.keyBoardView showInView:_curView];
}
#pragma mark - 监听textField的输入
- (void)monitorTextFieldInput:(NSString *)textString {
    
      _textField.text = textString;
    
    if (NumberTextFieldStylePassord ==  _textFieldStyle) {
        // 交易密码
        
    } else if (NumberTextFieldStylePhone == _textFieldStyle) {
        // 手机号码
        [MCNumberKeyboardMethod formatToPhone:_textField andString:textString];
        
    } else if (NumberTextFieldStyleBankCard == _textFieldStyle) {
        // 银行卡
        [MCNumberKeyboardMethod formatToBankCard:_textField andString:textString];
        
    } else if (NumberTextFieldStyleIdentityCard == _textFieldStyle) {
        // 身份证
        [MCNumberKeyboardMethod formatToIdentityCard:_textField andString:textString];
        [self monitorTextLength:textString];
        
    } else if (NumberTextFieldStyleInputWithoutDot == _textFieldStyle || NumberTextFieldStyleInputWithDot == _textFieldStyle) {
        // 输入金额
        [MCNumberKeyboardMethod formatToInputAmount:_textField andString:textString];
         [self monitorTextLength:textString];
    };
    
    // 输入小数点的限制
    _text = _textField.text;
   
}

#pragma mark - 重置
- (void)resetKeyBoardText {
    
    self.text = @"";
    [self initTextInputFlag:self.text];
}
#pragma mark - 退出键盘
- (void)keyBoardResignFirstResponder {
    [self.keyBoardView downInView];
}
#pragma mark - 弹出键盘
- (void)keyBoardBecomeFirstResponder {
    [self.keyBoardView showInView:_curView];
}
#pragma mark - 实时监听键盘输入
- (void)returnTextNumberBlcok:(returnTextNumberBlock)block {
    
    _block = block;
}

#pragma mark - 默认键盘view
- (MCNumberKeyboardView *)getDefaultKeyBoardView {
    
    if (!_keyBoardView) {
        _keyBoardView = [[MCNumberKeyboardView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT, MAIN_SCREEN_WIDTH, 216 + 39 + IPHONE_X_Bottom_SafeArea_Height)];
//        _keyBoardView = [[MCNumberKeyboardView alloc] init];
    }
    return _keyBoardView;
}
#pragma mark - 自定义键盘view
- (MCNumberKeyboardView *)getSelfDefineKeyBoardViewWithStyle:(NumberKeyboardStyle)numberKeyboardStyle {
    
    if (!_keyBoardView) {
      
        _keyBoardView = [[MCNumberKeyboardView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT - 216 - 39 - IPHONE_X_Bottom_SafeArea_Height, MAIN_SCREEN_WIDTH, 216 + 39 + IPHONE_X_Bottom_SafeArea_Height) andStyle:numberKeyboardStyle];
    }
    return _keyBoardView;
}

@end
