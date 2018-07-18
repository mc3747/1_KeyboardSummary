//
//  PasswordKeyboardTextField.m
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/16.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "PasswordKeyboardTextField.h"

@implementation PasswordKeyboardTextField

/** 重写回删的方法 */
- (void)deleteBackward {
    
    if (self.deleteBlock) {
        self.deleteBlock(self);
    };
    [super deleteBackward];
}
///**
// *  调用时刻 : 成为第一响应者(开始编辑\弹出键盘\获得焦点)
// */
//- (BOOL)becomeFirstResponder
//{
//    return [super becomeFirstResponder];
//}
//
///**
// *  调用时刻 : 不做第一响应者(结束编辑\退出键盘\失去焦点)
// */
//- (BOOL)resignFirstResponder
//{
//    return [super resignFirstResponder];
//}



@end
