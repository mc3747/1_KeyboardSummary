//
//  PasswordKeyboardTextField.h
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/16.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PasswordKeyboardTextField;
typedef  void (^DeleteBlock)(PasswordKeyboardTextField *textField);

@interface PasswordKeyboardTextField : UITextField
@property (nonatomic, copy) DeleteBlock deleteBlock;

@end
