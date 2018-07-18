//
//  GJSTextFieldMethod.h
//  GjFax
//
//  Created by gjfax on 2018/1/2.
//  Copyright © 2018年 GjFax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MCNumberKeyboardMethod : NSObject
//手机号 3 4 4
+ (void)formatToPhone:(UITextField *)textField andString:(NSString *)textString;
//银行卡 4 4 4
+ (void)formatToBankCard:(UITextField *)textField andString:(NSString *)textString;
//身份证 6 4 4 4
+ (void)formatToIdentityCard:(UITextField *)textField andString:(NSString *)textString;
//输入金额:最长10位
+ (void)formatToInputAmount:(UITextField *)textField andString:(NSString *)textString;
@end
