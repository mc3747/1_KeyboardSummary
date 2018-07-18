//
//  PasswordKeyboardView.m
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/16.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "PasswordKeyboardView.h"
@interface PasswordKeyboardView()<UITextFieldDelegate>
@property (nonatomic, strong) PasswordKeyboardTextField *num1F;
@property (nonatomic, strong) PasswordKeyboardTextField *num2F;
@property (nonatomic, strong) PasswordKeyboardTextField *num3F;
@property (nonatomic, strong) PasswordKeyboardTextField *num4F;
@property (nonatomic, strong) PasswordKeyboardTextField *num5F;
@property (nonatomic, strong) PasswordKeyboardTextField *num6F;
@property (nonatomic, strong) NSArray *tfArray;
@property (nonatomic, strong) PasswordKeyboardTextField *holdOnF;
/// 支付密码
@property (copy, nonatomic, readonly) NSString *payCode;
@end

@implementation PasswordKeyboardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self initBaseView:CGRectMake(1, 1, frame.size.width - 2, frame.size.height -2)];
        
        [self setFirstResponderForIndex:1];
        
        [self initClearButton:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self initHoldOnTF];
    }
    return self;
}
#pragma mark -  布局
- (void)initBaseView:(CGRect )frame {
    UIStackView *stackView = [[UIStackView alloc]initWithFrame:frame];
    //子视图布局方向：水平或垂直
    stackView.axis = UILayoutConstraintAxisHorizontal;//水平布局
    //子控件依据何种规矩布局
    stackView.distribution = UIStackViewDistributionFillEqually;//子控件均分
    //子控件之间的最小间距
    stackView.spacing = 1;
    //子控件的对齐方式
    stackView.alignment = UIStackViewAlignmentFill;
    //初始化子控件
    [self initTextField];
    //添加子控件
    [_tfArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [stackView addArrangedSubview:obj];
        
    }];
    //添加stackView
    [self addSubview:stackView];
    
}
#pragma mark -  透明button点击
-(void)initClearButton:(CGRect )frame{
    UIButton *clearButton = [[UIButton alloc] initWithFrame:frame];
    [clearButton setBackgroundColor:[UIColor clearColor]];
    [clearButton addTarget:self action:@selector(textFieldDidBegain:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clearButton];
}
#pragma mark - 保持键盘tf
- (void)initHoldOnTF{
    _holdOnF = [[PasswordKeyboardTextField alloc]initWithFrame:CGRectZero];
    GJWeakSelf;
    //监听删除
    _holdOnF.deleteBlock = ^(PasswordKeyboardTextField *textField) {
        [weakSelf monitorDeleteAction:textField];
    };
    
    //监听输入
    [_holdOnF addTarget:weakSelf action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _holdOnF.delegate = self;
    _holdOnF.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_holdOnF];
}
#pragma mark -  初始化textfield
- (void)initTextField {
    _num1F = [self returnTextFied];
    _num2F = [self returnTextFied];
    _num3F = [self returnTextFied];
    _num4F = [self returnTextFied];
    _num5F = [self returnTextFied];
    _num6F = [self returnTextFied];
    _tfArray = @[_num1F,_num2F,_num3F,_num4F,_num5F,_num6F];
    GJWeakSelf;
    [_tfArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //监听删除
        ((PasswordKeyboardTextField *)obj).deleteBlock = ^(PasswordKeyboardTextField *textField) {
            [weakSelf monitorDeleteAction:textField];
        };
        
        //监听输入
        [((PasswordKeyboardTextField *)obj) addTarget:weakSelf action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

        
    }];

}
#pragma mark -  textfield基本设置
- (PasswordKeyboardTextField *)returnTextFied {
    PasswordKeyboardTextField *textField = [[PasswordKeyboardTextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.tintColor = [UIColor redColor];
    textField.delegate = self;
    
    return textField;
}

#pragma mark -  设置第一响应者
- (void)setFirstResponderForIndex:(NSInteger)index
{

    switch (index) {
        case 1:
            [_num1F becomeFirstResponder];break;
        case 2:
            [_num2F becomeFirstResponder];break;
        case 3:
            [_num3F becomeFirstResponder];break;
        case 4:
            [_num4F becomeFirstResponder];break;
        case 5:
            [_num5F becomeFirstResponder];break;
        case 6:
            [_num6F becomeFirstResponder];break;
        default:break;
    }
}

#pragma mark -  删除监听
- (void)monitorDeleteAction:(PasswordKeyboardTextField *)textField {
    
    if (textField.text.length==0) {
        
        if ([textField isEqual:_num1F]) {
            
        }else if ([textField isEqual:_num2F] ) {
            [self setFirstResponderForIndex:1];
            _num1F.text = nil;
            
        }else if ([textField isEqual:_num3F] ) {
            [self setFirstResponderForIndex:2];
            _num2F.text = nil;
            
        }else if ([textField isEqual:_num4F] ) {
            [self setFirstResponderForIndex:3];
            _num3F.text = nil;
            
        }else if ([textField isEqual:_num5F] ) {
            [self setFirstResponderForIndex:4];
            _num4F.text = nil;
            
        }else if ([textField isEqual:_num6F]){
            [self setFirstResponderForIndex:5];
            _num5F.text = nil;
            
        }else if ([textField isEqual:_holdOnF]){
            _holdOnF.text = nil;
            _num6F.text = nil;
            [self setFirstResponderForIndex:6];
        }
        
    } else {
        
        if ([textField isEqual:_num6F]){
            [self setFirstResponderForIndex:5];
            _num6F.text = nil;
            
        }else if ([textField isEqual:_num5F]){
            [self setFirstResponderForIndex:4];
            _num5F.text = nil;
            
        }else if ([textField isEqual:_num4F]){
            [self setFirstResponderForIndex:3];
            _num4F.text = nil;
            
        }else if ([textField isEqual:_num3F]){
            [self setFirstResponderForIndex:2];
            _num3F.text = nil;
            
        }else if ([textField isEqual:_num2F]){
            [self setFirstResponderForIndex:1];
            _num2F.text = nil;
            
        }else if ([textField isEqual:_num1F]){
            [self setFirstResponderForIndex:1];
            _num1F.text = nil;
        };
        
    };
    
    if (self.endEditingOnFinished) return;
    // 收集支付密码
    [self collectPayCode];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isEqual:_holdOnF]) {
        return NO;
    }
    return YES;
}

#pragma mark -  按下监听
- (void)textFieldDidBegain:(UITextField *)textField{

    if ([_num1F.text isEqual:@""]) {
        [self setFirstResponderForIndex:1];

    }else if ([_num2F.text isEqual:@""]) {
        [self setFirstResponderForIndex:2];

    }else if ([_num3F.text isEqual:@""]) {
        [self setFirstResponderForIndex:3];

    }else if ([_num4F.text isEqual:@""]) {
        [self setFirstResponderForIndex:4];

    }else if ([_num5F.text isEqual:@""]) {
        [self setFirstResponderForIndex:5];

    }else if ([_num6F.text isEqual:@""]) {
        [self setFirstResponderForIndex:6];
        
    }else {
        [self setFirstResponderForIndex:6];
    };
    
}

#pragma mark - 输入监听(输入之后)
- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.text.length >0) {
        NSString *text = textField.text;
        text = [text substringFromIndex:text.length - 1];
        textField.text = text;
    };
   
    // 收集支付密码
    [self collectPayCode];
    
    if ([textField isEqual:_num1F]) {
        [self setFirstResponderForIndex:2];
        
    }else if ([textField isEqual:_num2F] ) {
        [self setFirstResponderForIndex:3];
        
    }else if ([textField isEqual:_num3F] ) {
        [self setFirstResponderForIndex:4];
        
    }else if ([textField isEqual:_num4F] ) {
        [self setFirstResponderForIndex:5];
        
    }else if ([textField isEqual:_num5F] ) {
        [self setFirstResponderForIndex:6];
        
    }else if ([textField isEqual:_num6F]){
        
        if (self.endEditingOnFinished) { // 是否退下键盘
            [_num6F resignFirstResponder];
        }else{
            [_holdOnF becomeFirstResponder];
        };
        
        if (_payBlock) {
            _payBlock(_payCode);
        }
    }
}
#pragma mark -   收集支付密码
- (void)collectPayCode
{
    NSString *payCode = _num1F.text;
    payCode = [payCode stringByAppendingString:_num2F.text];
    payCode = [payCode stringByAppendingString:_num3F.text];
    payCode = [payCode stringByAppendingString:_num4F.text];
    payCode = [payCode stringByAppendingString:_num5F.text];
    payCode = [payCode stringByAppendingString:_num6F.text];
    _payCode = payCode;
    
    if (self.endEditingOnFinished) return;
    if (_payBlock) {
        _payBlock(_payCode);
    }
}
#pragma mark -  明暗文显示
- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    if (secureTextEntry) {
        [_tfArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ((PasswordKeyboardTextField *)obj).secureTextEntry = YES;
            ((PasswordKeyboardTextField *)obj).textAlignment = NSTextAlignmentCenter;
            ((PasswordKeyboardTextField *)obj).font = [UIFont systemFontOfSize:30];
        }];
    };
   
}
@end
