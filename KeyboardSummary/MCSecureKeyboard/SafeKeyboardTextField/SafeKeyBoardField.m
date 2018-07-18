//
//  MCSafeKeyboardTextField.m
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/23.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "SafeKeyBoardField.h"
#import "MCAccessoryLayout.h"
#import "MCNumberKeyboardLayout.h"
#import "MCCharacterKeyboardLayout.h"
#import "MCSpecialKeyboardLayout.h"
#import "UIView+Extension.h"

/** 键盘主体高度 */
static CGFloat const kMainKeyboardHeight = 216;
/** 键盘顶部高度 */
static CGFloat const kAccessoryKeyboardHeight = 39;

@interface SafeKeyBoardField()

@property (nonatomic, strong) MCAccessoryLayout         *accessoryLayout;
@property (nonatomic, strong) MCCharacterKeyboardLayout *characterKeyboardLayout;
@property (nonatomic, strong) MCNumberKeyboardLayout    *numberKeyboardLayout;
@property (nonatomic, strong) MCSpecialKeyboardLayout   *specialKeyboardLayout;

@end


@implementation SafeKeyBoardField
#pragma mark - 键盘销毁
- (void)dealloc {
     DLog(@"销毁安全键盘整个textField");
//    [self removeSafeKeyboard];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self keyboardEvent];
//        self.autocorrectionType = UITextAutocorrectionTypeNo;
        
    }
    return self;
}

- (void)keyboardEvent
{
    //监听键盘出现和消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 键盘出现
- (void)keyboardWillShow:(NSNotification *)note
{
    if (self.keyBordWillShowBlock) {
        self.keyBordWillShowBlock();
    }
}
#pragma mark 键盘消失
- (void)keyboardWillHide:(NSNotification *)note
{
    if (self.keyBordWillHideBlock) {
        self.keyBordWillHideBlock();
    }
}

#pragma mark - 设置键盘类型
- (void)setSafeKeyBoardType:(SafeKeyBoardType)safeKeyBoardType {
    _safeKeyBoardType = safeKeyBoardType;
    [self addTarget:self action:@selector(removeFocus) forControlEvents:UIControlEventEditingDidEnd];
    [self addTarget:self action:@selector(recoveryFocus) forControlEvents:UIControlEventEditingDidBegin];
    if (safeKeyBoardType == SafeKeyBoardTypeCharacter) {
        self.inputView = self.characterKeyboardLayout;
    } else if (safeKeyBoardType == SafeKeyBoardTypeNumber) {
        self.inputView = self.numberKeyboardLayout;
    } else if (safeKeyBoardType == SafeKeyBoardTypeSpecialCharacter) {
        self.inputView = self.specialKeyboardLayout;
    }
    
    self.inputAccessoryView = self.accessoryLayout;
}
#pragma mark - 键盘切换
- (void)changeSafeKeyBoardType:(SafeKeyBoardType)safeKeyBoardType {
    [self nilSafeKeyboard];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        if (safeKeyBoardType == SafeKeyBoardTypeNumber) {
            
            self.inputView = self.numberKeyboardLayout;
            
        }else if (safeKeyBoardType == SafeKeyBoardTypeCharacter) {
            self.inputView = self.characterKeyboardLayout;
            
        } else if (safeKeyBoardType == SafeKeyBoardTypeSpecialCharacter) {
            self.inputView = self.specialKeyboardLayout;
        }

        [self reloadInputViews];
    }];
}
#pragma mark - 恢复焦点
- (void)recoveryFocus {
//        DLog(@"恢复焦点，弹出键盘");
    
    if (_safeKeyBoardType == SafeKeyBoardTypeNumber) {
        
        self.inputView = self.numberKeyboardLayout;
        
    }else if (_safeKeyBoardType == SafeKeyBoardTypeCharacter) {
        self.inputView = self.characterKeyboardLayout;
        
    } else if (_safeKeyBoardType == SafeKeyBoardTypeSpecialCharacter) {
        self.inputView = self.specialKeyboardLayout;
    }
    self.inputAccessoryView = self.accessoryLayout;
}
#pragma mark - 移除焦点
-(void)removeFocus
{
//    DLog(@"移除焦点，移除键盘");
    [self removeSafeKeyboard];
  
}
#pragma mark - 输入事件
- (void)inputString:(NSString *)string
{
    self.text = [self.text stringByAppendingString:string];
    if (_returnBlock) {
        _returnBlock(self,self.text);
    }
}
#pragma mark - 输入空格
- (void)inputBlankSpace {
    if (!_forbidSpace) {
        [self inputString:@" "];
    }
}
#pragma mark - 是否禁止使用剪切板（重写系统方法）
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (self.forbidClipboard) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
    
}
#pragma mark - 收起键盘
- (void)retractKeyboard {
    [self resignFirstResponder];
}
#pragma mark - 删除事件
- (void)deleteAction
{
    NSUInteger length = self.text.length;
    if (length == 0 ) {
        if (_returnBlock) {
            _returnBlock(self, self.text);
        }
        return;
    }
    
    NSRange range = NSMakeRange(0, length - 1);
    self.text = [self.text substringWithRange:range];
    if (_returnBlock) {
        _returnBlock(self, self.text);
    }
    
}
#pragma mark - 键盘禁止类型
- (void)forbidKeyBoardType:(SafeKeyBoardType)keyBoardType
{
    if (keyBoardType == SafeKeyBoardTypeNumber) {
        
        _forbidNumber = YES;
        
        
    }else if (keyBoardType == SafeKeyBoardTypeCharacter) {
        
        _forbidABC = YES;
        
    }else if (keyBoardType == SafeKeyBoardTypeSpecialCharacter) {
        
        _forbidSpecialCharacter = YES;
    }
}
#pragma mark - 输入变化传出
- (void)shouldChangeCharacters:(keyBoardReturnStringBlock)returnBlock {
    _returnBlock = returnBlock;
}
#pragma mark - 置空键盘
- (void)nilSafeKeyboard {
     DLog(@"置空键盘");
    self.characterKeyboardLayout = nil;
    self.accessoryLayout = nil;
    self.numberKeyboardLayout = nil;
    self.specialKeyboardLayout = nil;
}
#pragma mark - 移除键盘 && 销毁键盘
-(void)removeSafeKeyboard
{
//    DLog(@"销毁键盘");

//    self.characterKeyboardLayout = nil;
//    self.accessoryLayout = nil;
//    self.numberKeyboardLayout = nil;
//    self.specialKeyboardLayout = nil;
//    
//    self.inputView = nil;
//    self.inputAccessoryView = nil;
}
#pragma mark - 顶部提示layout
- (MCAccessoryLayout *)accessoryLayout
{
    if (!_accessoryLayout) {
        _accessoryLayout = [[MCAccessoryLayout alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kMainKeyboardHeight - kAccessoryKeyboardHeight, [UIScreen mainScreen].bounds.size.width, kAccessoryKeyboardHeight)];
        __weak typeof (self)weakSelf = self;
        // 收起键盘小图标
        [_accessoryLayout getAccessoryFinishClickBlock:^{
            [weakSelf retractKeyboard];
            
        }];
    }
    
    if (_isHiddenAccessoryView) {
        _accessoryLayout = nil;
    }
      return _accessoryLayout;

}
#pragma mark - 字母键盘layout
- (MCCharacterKeyboardLayout *)characterKeyboardLayout
{
    if (!_characterKeyboardLayout) {
        _characterKeyboardLayout = [[MCCharacterKeyboardLayout alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kMainKeyboardHeight - IPHONE_X_Bottom_SafeArea_Height, [UIScreen mainScreen].bounds.size.width, kMainKeyboardHeight + IPHONE_X_Bottom_SafeArea_Height)];
        __weak typeof (self)weakSelf = self;
        
        // 输入
        [_characterKeyboardLayout getClickCharacterBlock:^(NSString *characterStr) {
            
            [weakSelf inputString:characterStr];
        }];
        // 删除
        [_characterKeyboardLayout getDeleteCharacterBlock:^{
            [weakSelf deleteAction];
        }];
        // 空格
        [_characterKeyboardLayout getClickBlankSpaceBlock:^{
            [weakSelf inputBlankSpace];
        }];
        // 切换到数字键盘
        [_characterKeyboardLayout getChangerToNumberBlock:^{
            if (!weakSelf.forbidNumber) {
                [weakSelf changeSafeKeyBoardType:SafeKeyBoardTypeNumber];
            }
        }];
        // 切换到特殊字符键盘
        [_characterKeyboardLayout getChangerToSpecialBlock:^{
            if (!weakSelf.forbidSpecialCharacter) {
                [weakSelf changeSafeKeyBoardType:SafeKeyBoardTypeSpecialCharacter];
            }
        }];
    }

    return _characterKeyboardLayout;
}

#pragma mark - 数字键盘layout
- (MCNumberKeyboardLayout *)numberKeyboardLayout
{
    if (!_numberKeyboardLayout) {
         
        _numberKeyboardLayout = [[MCNumberKeyboardLayout alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kMainKeyboardHeight - IPHONE_X_Bottom_SafeArea_Height, [UIScreen mainScreen].bounds.size.width, kMainKeyboardHeight + IPHONE_X_Bottom_SafeArea_Height)];
        __weak typeof (self)weakSelf = self;
        // 输入
        [_numberKeyboardLayout getClikNumberBlock:^(NSString *numberStr) {
            [weakSelf inputString:numberStr];
        }];
        // 删除
        [_numberKeyboardLayout getClikDeleteBlock:^{
            [weakSelf deleteAction];
        }];
        // 切换到字母键盘
        [_numberKeyboardLayout getClikToCharacterBlock:^{
            if (!weakSelf.forbidSpecialCharacter) {
                [weakSelf changeSafeKeyBoardType:SafeKeyBoardTypeCharacter];
            }
        }];
       
    }
    _numberKeyboardLayout.isNumberKeyboardOrder = _isNumberKeyboardOrder;
    return _numberKeyboardLayout;
}

#pragma mark - 特殊字符键盘layout
- (MCSpecialKeyboardLayout *)specialKeyboardLayout
{
    if (!_specialKeyboardLayout) {
        _specialKeyboardLayout = [[MCSpecialKeyboardLayout alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kMainKeyboardHeight - IPHONE_X_Bottom_SafeArea_Height, [UIScreen mainScreen].bounds.size.width, kMainKeyboardHeight + IPHONE_X_Bottom_SafeArea_Height)];
        __weak typeof (self)weakSelf = self;
        // 输入
        [_specialKeyboardLayout getClickSpecialBlock:^(NSString *specialStr) {
            [weakSelf inputString:specialStr];
        }];
        // 删除
        [_specialKeyboardLayout getDeleteSpecialBlock:^{
            [weakSelf deleteAction];
        }];
        // 切换到字母键盘
        [_specialKeyboardLayout getChangerToCharacterBlock:^{
            if (!weakSelf.forbidSpecialCharacter) {
                [weakSelf changeSafeKeyBoardType:SafeKeyBoardTypeCharacter];
            }
        }];
        // 切换到数字键盘
        [_specialKeyboardLayout getChangerToNumberBlock:^{
            if (!weakSelf.forbidNumber) {
                [weakSelf changeSafeKeyBoardType:SafeKeyBoardTypeNumber];
            }
        }];
    }

     
    return _specialKeyboardLayout;
}
@end
