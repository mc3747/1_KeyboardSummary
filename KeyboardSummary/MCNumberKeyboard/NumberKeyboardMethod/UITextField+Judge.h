//
//  UITextField+Judge.h
//  HX_GJS
//
//  Created by litao on 15/12/21.
//  Copyright © 2015年 GjFax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Judge)
/**
 *  金额输入框 - 输入合格性校验
 *  规则:
 *  [第一位不允许输入小数点'.']
 *  [只允许出现一次小数点]
 *  [只支持输入小数点后2位]
 *  @param string 输入的字符串
 *  @param range  range
 *
 *  @return 是否通过校验 - 允许输入
 */
- (BOOL)moneyInputJudge:(NSString *)string range:(NSRange)range;
@end
