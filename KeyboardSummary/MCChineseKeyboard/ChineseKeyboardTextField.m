//
//  ChineseKeyboardTextField.m
//  GjFax
//
//  Created by gjfax on 2018/5/7.
//  Copyright © 2018年 GjFax. All rights reserved.
//

#import "ChineseKeyboardTextField.h"
@interface ChineseKeyboardTextField()
@property (nonatomic, weak) UIView *topView;

@end
@implementation ChineseKeyboardTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configChineseKeyboard];
    }
    return self;
}

- (void)configChineseKeyboard {
    [self textFieldSetting];
    [self addToolBar];
}
#pragma mark -  textField设置
- (void)textFieldSetting{
    self.placeholder = @"真实姓名";
    self.textColor = COMMON_GREY_COLOR;
    self.font = [UIFont systemFontOfSize:14.f];
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.keyboardType = UIKeyboardTypeDefault;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.returnKeyType=UIReturnKeyGo;
    self.keyboardAppearance=UIKeyboardAppearanceLight;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.spellCheckingType = UITextSpellCheckingTypeNo;
    if (@available(iOS 11.0, *)) {
//        self.smartQuotesType = UITextSmartQuotesTypeNo;
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 11.0, *)) {
        self.smartDashesType = UITextSmartDashesTypeNo;
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 11.0, *)) {
        self.textContentType = UITextContentTypeUsername;
    } else {
        // Fallback on earlier versions
    }
    self.adjustsFontSizeToFitWidth = YES;
    
}
#pragma mark -  添加toolBar
- (void)addToolBar {
    UIToolbar *kbToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 44)];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyboard)];
    [doneItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor blueColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
     [doneItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:COMMON_BLUE_GREEN_COLOR forKey:NSForegroundColorAttributeName] forState:UIControlStateHighlighted];
    kbToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneItem];
    
    self.inputAccessoryView = kbToolbar;
}
#pragma mark -  点击完成
- (void)closeKeyboard {
    [self resignFirstResponder];
}

#pragma mark -  输入内容
- (void)textFieldChanged:(UITextField *)textField {
    NSLog(@"%@",textField.text);
}
@end
