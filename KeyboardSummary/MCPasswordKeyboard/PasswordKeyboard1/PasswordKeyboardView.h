//
//  PasswordKeyboardView.h
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/16.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasswordKeyboardTextField.h"

typedef void (^PayCodeBlock)(NSString *payCode);

@interface PasswordKeyboardView : UIView

/// 设置是否暗文显示
@property (assign, nonatomic) BOOL secureTextEntry;

/// 最后一位输入完成时，是否退下键盘
@property (assign, nonatomic) BOOL endEditingOnFinished;

/// 输入完成block
@property (copy, nonatomic) PayCodeBlock payBlock;

@end
