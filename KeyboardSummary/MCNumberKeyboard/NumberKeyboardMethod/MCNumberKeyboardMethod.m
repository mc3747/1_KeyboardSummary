//
//  GJSTextFieldMethod.m
//  GjFax
//
//  Created by gjfax on 2018/1/2.
//  Copyright © 2018年 GjFax. All rights reserved.
//

#import "MCNumberKeyboardMethod.h"

@implementation MCNumberKeyboardMethod

#pragma mark - 手机号码格式
//手机号 3 4 4
+ (void)formatToPhone:(UITextField *)textField andString:(NSString *)textString{
    //限制手机账号长度（有两个空格）
    if (textField.text.length > 13) {
        textField.text = [textField.text substringToIndex:13];
        //  Show_iToast(FMT_STR(@"手机号禁止输入超过11位"));
    }
    
    NSUInteger targetCursorPosition = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    
    NSString *currentStr = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *preStr = [textString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUInteger curTargetCursorPosition = [self changePhoneStringPosition:currentStr preStr:preStr position:targetCursorPosition];
    
    textField.text = [self checkPhoneRuleString:currentStr];
    UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument] offset:curTargetCursorPosition];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition :targetPosition]];

}

+ (NSUInteger)changePhoneStringPosition:(NSString *)currentStr
                                 preStr:(NSString *)preStr
                               position:(NSUInteger )targetCursorPosition
{
    char editFlag = 0;
    if (currentStr.length <= preStr.length) {
        editFlag = 0;
    }
    else {
        editFlag = 1;
    }
    
    // 当前光标的偏移位置
    NSUInteger curTargetCursorPosition = targetCursorPosition;
    
    if (editFlag == 0) {
        //删除
        if (targetCursorPosition == 9 || targetCursorPosition == 4) {
            curTargetCursorPosition = targetCursorPosition - 1;
        }
    }else {
        //添加
        if (currentStr.length == 8 || currentStr.length == 4) {
            if (targetCursorPosition != 5 && targetCursorPosition != 10) {
                curTargetCursorPosition = targetCursorPosition + 1;
            }
        }
    }
    return curTargetCursorPosition;
}

+ (NSMutableString *)checkPhoneRuleString:(NSString *)currentStr
{
    NSMutableString *tempStr = [NSMutableString new];
    
    int spaceCount = 0;
    if (currentStr.length < 3 && currentStr.length > -1) {
        spaceCount = 0;
    }else if (currentStr.length < 7 && currentStr.length > 2) {
        spaceCount = 1;
    }else if (currentStr.length < 12 && currentStr.length > 6) {
        spaceCount = 2;
    }
    
    for (int i = 0; i < spaceCount; i++) {
        if (i == 0) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(0, 3)], @" "];
        }else if (i == 1) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(3, 4)], @" "];
        }else if (i == 2) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(7, 4)], @" "];
        }
    }
    
    if (currentStr.length == 11) {
        [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(7, 4)], @" "];
    }
    if (currentStr.length < 4) {
        [tempStr appendString:[currentStr substringWithRange:NSMakeRange(currentStr.length - currentStr.length % 3, currentStr.length % 3)]];
    }else if(currentStr.length > 3 && currentStr.length < 13) {
        NSString *str = [currentStr substringFromIndex:3];
        [tempStr appendString:[str substringWithRange:NSMakeRange(str.length - str.length % 4, str.length % 4)]];
        if (currentStr.length == 11) {
            [tempStr deleteCharactersInRange:NSMakeRange(13, 1)];
        }
    }
    
    return tempStr;
}
#pragma mark - 银行卡格式
//银行卡 4 4 4
+ (void)formatToBankCard:(UITextField *)textField andString:(NSString *)textString {
    if (textField.text.length > 23) {
        textField.text = [textField.text substringToIndex:23];
        // Show_iToast(FMT_STR(@"银行卡号长度不能超过19位!"));
    }
    
    NSUInteger targetCursorPosition = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    NSString *currentStr = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *preStr = [textString stringByReplacingOccurrencesOfString:@" " withString:@""];

    
    textField.text = [self checkBankCardRuleString:currentStr];
    
    // 当前光标的偏移位置
    NSUInteger curTargetCursorPosition = [self changeBankCardStringPosition:currentStr preStr:preStr position:targetCursorPosition];
    
    UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument] offset:curTargetCursorPosition];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition :targetPosition]];
    
}
//改变输入位置
+ (NSUInteger)changeBankCardStringPosition:(NSString *)currentStr
                                    preStr:(NSString *)preStr
                                  position:(NSUInteger )targetCursorPosition
{
    int editFlag = 0;
    if (currentStr.length <= preStr.length) {
        editFlag = 0;
    } else {
        editFlag = 1;
        
    }
    
    NSUInteger curTargetCursorPosition = targetCursorPosition;
    
    if (editFlag == 0) {
        //删除
        if (targetCursorPosition == 5 || targetCursorPosition == 10 || targetCursorPosition == 15 || targetCursorPosition == 20) {
            curTargetCursorPosition = targetCursorPosition - 1;
        }
    }else {
        //添加
        if (currentStr.length == 5 || currentStr.length == 9 || currentStr.length == 13 || currentStr.length == 17) {
            if (targetCursorPosition != 21 && targetCursorPosition != 16 && targetCursorPosition != 11 && targetCursorPosition != 6) {
                curTargetCursorPosition = targetCursorPosition + 1;
                
            }
        }
    }
    return curTargetCursorPosition;
}

//添加空格
+ (NSMutableString *)checkBankCardRuleString:(NSString *)currentStr
{
    NSMutableString *tempStr = [NSMutableString new];
    
    int spaceCount = 0;
    if (currentStr.length < 4 && currentStr.length > -1) {
        spaceCount = 0;
    }else if (currentStr.length < 8 && currentStr.length > 3) {
        spaceCount = 1;
    }else if (currentStr.length < 12 && currentStr.length > 7) {
        spaceCount = 2;
    } else if (currentStr.length < 16 && currentStr.length > 11) {
        spaceCount = 3;
    } else if (currentStr.length < 20 && currentStr.length > 15) {
        spaceCount = 4;
    }
    
    for (int i = 0; i < spaceCount; i++) {
        if (i == 0) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(0, 4)], @" "];
        } else if (i == 1) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(4, 4)], @" "];
        } else if (i == 2) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(8, 4)], @" "];
        } else if (i == 3) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(12, 4)], @" "];
        } else if (i == 4) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(16, currentStr.length - 16)], @" "];
        }
        //DLog(@"temp %@",tempStr);
    }
    
    if (currentStr.length < 5) {
        [tempStr appendString:[currentStr substringWithRange:NSMakeRange(currentStr.length - currentStr.length % 4, currentStr.length % 4)]];
        //DLog(@"tempStr <7 %@",tempStr);
    } else if (currentStr.length > 4 && currentStr.length < 9) {
        
        NSString *str = [currentStr substringFromIndex:4];
        [tempStr appendString:[str substringWithRange:NSMakeRange(str.length - str.length % 4, str.length % 4)]];
        //DLog(@"tempStr <8 %@ str %@",tempStr,str);
    } else if (currentStr.length > 8 && currentStr.length < 13) {
        NSString *str = [currentStr substringFromIndex:8];
        [tempStr appendString:[str substringWithRange:NSMakeRange(str.length - str.length % 4, str.length % 4)]];
        //DLog(@"tempStr <12 %@ str %@",tempStr,str);
    } else if (currentStr.length > 12 && currentStr.length < 17) {
        
        NSString *str = [currentStr substringFromIndex:12];
        [tempStr appendString:[str substringWithRange:NSMakeRange(str.length - str.length % 4, str.length % 4)]];
        //DLog(@"tempStr <17 %@ str %@",tempStr,str);
    }else if(currentStr.length > 16 && currentStr.length < 20) {
        NSString *str = [currentStr substringFromIndex:16];
        [tempStr appendString:[str substringWithRange:NSMakeRange(str.length - str.length % 4, str.length % 4)]];
        //        if (currentStr.length == 19) {
        //            [tempStr deleteCharactersInRange:NSMakeRange(23, 1)];
        //        }
        //DLog(@"tempStr <21 %@",tempStr);
    }
    return tempStr;
}

#pragma mark - 身份证格式
//身份证 6 4 4 4
+ (void)formatToIdentityCard:(UITextField *)textField andString:(NSString *)textString {
    if (textField.text.length > 21) {
        textField.text = [textField.text substringToIndex:21];
        // Show_iToast(FMT_STR(@"禁止输入超过18个字符"));
    }
    
    NSUInteger targetCursorPosition = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    
    NSString *currentStr = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *preStr = [textString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (currentStr.length == 18 && [[currentStr substringFromIndex:17] isEqualToString:@"x"]) {
        currentStr = [currentStr stringByReplacingOccurrencesOfString:@"x" withString:@"X"];
    }
    
    textField.text = [self checkIdentityCardRuleString:currentStr];
    
    // 当前光标的偏移位置
    NSUInteger curTargetCursorPosition = [self changeIdentityCardStringPosition:currentStr preStr:preStr position:targetCursorPosition];
    
    UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument] offset:curTargetCursorPosition];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition :targetPosition]];
}
//添加空格
+ (NSMutableString *)checkIdentityCardRuleString:(NSString *)currentStr
{
    NSMutableString *tempStr = [NSMutableString new];
    
    int spaceCount = 0;
    if (currentStr.length < 6 && currentStr.length > -1) {
        spaceCount = 0;
    }else if (currentStr.length < 10 && currentStr.length > 5) {
        spaceCount = 1;
    }else if (currentStr.length < 14 && currentStr.length > 9) {
        spaceCount = 2;
    } else if (currentStr.length < 19 && currentStr.length > 13) {
        spaceCount = 3;
    }
    
    for (int i = 0; i < spaceCount; i++) {
        if (i == 0) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(0, 6)], @" "];
        } else if (i == 1) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(6, 4)], @" "];
        } else if (i == 2) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(10, 4)], @" "];
        } else if (i == 3) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(14, 4)], @" "];
        }
    }
    //DLog(@"tempStr 1 %@ count %d",tempStr,spaceCount);
    if (currentStr.length == 18) {
        [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(14, 4)], @" "];
        //DLog(@"tempStr 18 %@",tempStr);
    }
    if (currentStr.length < 7) {
        [tempStr appendString:[currentStr substringWithRange:NSMakeRange(currentStr.length - currentStr.length % 6, currentStr.length % 6)]];
        //DLog(@"tempStr <7 %@",tempStr);
    } else if (currentStr.length > 6 && currentStr.length < 15) {
        
        NSString *str = [currentStr substringFromIndex:6];
        [tempStr appendString:[str substringWithRange:NSMakeRange(str.length - str.length % 4, str.length % 4)]];
        //DLog(@"tempStr <16 %@ str %@",tempStr,str);
    }else if(currentStr.length > 14 && currentStr.length < 21) {
        NSString *str = [currentStr substringFromIndex:14];
        [tempStr appendString:[str substringWithRange:NSMakeRange(str.length - str.length % 4, str.length % 4)]];
        if (currentStr.length == 18) {
            [tempStr deleteCharactersInRange:NSMakeRange(21, 1)];
        }
        //DLog(@"tempStr <21 %@",tempStr);
    }
    return tempStr;
}
//改变输入位置
+ (NSUInteger)changeIdentityCardStringPosition:(NSString *)currentStr
                                        preStr:(NSString *)preStr
                                      position:(NSUInteger )targetCursorPosition
{
    int editFlag = 0;
    if (currentStr.length <= preStr.length) {
        editFlag = 0;
    } else {
        editFlag = 1;
        
    }
    NSUInteger curTargetCursorPosition = targetCursorPosition;
    
    if (editFlag == 0) {
        //删除
        if (targetCursorPosition == 7 || targetCursorPosition == 12 || targetCursorPosition == 17) {
            curTargetCursorPosition = targetCursorPosition - 1;
        }
    }else {
        //添加
        if (currentStr.length == 7 || currentStr.length == 11 || currentStr.length == 15) {
            if (targetCursorPosition != 8 && targetCursorPosition != 13 && targetCursorPosition != 18) {
                curTargetCursorPosition = targetCursorPosition + 1;
            }
        }
    }
    return curTargetCursorPosition;
}
#pragma mark - 输入金额
//输入金额:最大长度10位？/首位是否能够为0？/输入小数点后的规则
+ (void)formatToInputAmount:(UITextField *)textField andString:(NSString *)textString {
    
    NSInteger kMaxLength = 10;
    // 手机号码超过11位，进行限制
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (textField.text.length > kMaxLength) {
            textField.text = [textField.text substringToIndex:kMaxLength];
        }
    };
    
}
@end
