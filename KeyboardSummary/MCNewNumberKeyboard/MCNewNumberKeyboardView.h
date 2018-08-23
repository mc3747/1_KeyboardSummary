//
//  MCNewNumberKeyboardView.h
//  KeyboardSummary
//
//  Created by gjfax on 2018/8/18.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCNewNumberKeyboardTextField.h"

@interface MCNewNumberKeyboardView : UIView
@property (nonatomic, strong) MCNewNumberKeyboardTextField *textField;
@property (nonatomic, strong) UIView *warningView;

- (instancetype)initWithFrame:(CGRect)frame andStyle:(NumberTextFieldStyle )textFieldStyle;

//显示警告
- (void)showWarningView:(NSString *)text;

//隐藏警告
- (void)hideWarningView;
@end
