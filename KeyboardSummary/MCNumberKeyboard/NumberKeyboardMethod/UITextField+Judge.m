//
//  UITextField+Judge.m
//  HX_GJS
//
//  Created by litao on 15/12/21.
//  Copyright © 2015年 GjFax. All rights reserved.
//

#import "UITextField+Judge.h"

@implementation UITextField (Judge)
- (BOOL)moneyInputJudge:(NSString *)string range:(NSRange)range
{
    //  首位不允许输入'.'号 - 不允许第二个'.'
    if (string.length > 0) {
        unichar newChar = [string characterAtIndex:0];
        if (newChar == '.' && range.length == 0 && range.location == 0) {
            return NO;
        }
        
        NSString *existText = self.text;
        if ([existText rangeOfString:@"."].location != NSNotFound && newChar == '.') {
            return NO;
        }
    }
    
    //  限制小数点后最多两位
    NSMutableString * futureString = [NSMutableString stringWithString:self.text];
    [futureString insertString:string atIndex:range.location];
    
    NSInteger flag = 0;
    const NSInteger limited = 2;
    for (int i = (int)futureString.length - 1; i >= 0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            
            if (flag > limited) {
                return NO;
            }
            
            break;
        }
        flag++;
    }
    
    return YES;
}
@end
