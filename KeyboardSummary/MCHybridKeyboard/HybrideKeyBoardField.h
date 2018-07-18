//
//  MCSafeKeyboardTextField.h
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/23.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HybrideKeyBoardField;
/**  键盘类型*/
typedef NS_ENUM(NSInteger, HybrideKeyBoardType) {
    HybrideKeyBoardTypeCharacter           =  10008,  //字母键盘
    HybrideKeyBoardTypeSpecial             =  10009,  //特殊字符键盘
    
};
/**  键盘输入值变化block*/
typedef void(^HbrideReturnBlock)(HybrideKeyBoardField *textField, NSString *string);


/** 键盘显示block*/
typedef void(^keyBoardWillShowBlock)(void);

/** 键盘隐藏block*/
typedef void(^keyBoardWillHideBlock)(void);


@interface HybrideKeyBoardField : UITextField
/*
 *  监听键盘输入值的变化
 */
@property (nonatomic, copy) HbrideReturnBlock   returnBlock;
/*
 *  键盘类型
 */
@property (nonatomic, assign) HybrideKeyBoardType    safeKeyBoardType;
/*
 *  禁止空格  默认 NO，即可使用空格
 */
@property (nonatomic, assign) BOOL                      forbidSpace;
/*
 *  禁止剪贴板  默认 NO，即可使用剪贴板
 */
@property (nonatomic, assign) BOOL                      forbidClipboard;
/*
 *  禁止数字键盘  默认 NO，即可使用数字键盘
 */
@property (nonatomic, assign) BOOL                      forbidNumber;
/*
 *  禁止字母键盘  默认 NO，即可使用字母键盘
 */
@property (nonatomic, assign) BOOL                      forbidABC;
/*
 *  禁止特殊字符键盘  默认 NO，即可使用特殊字符键盘
 */
@property (nonatomic, assign) BOOL                      forbidSpecialCharacter;

/*
 *  是否隐藏顶部辅助视图 默认 NO，即不隐藏
 */
@property (nonatomic, assign) BOOL                      isHiddenAccessoryView;

/*
 *  数字键盘是否乱序 默认 NO，即是乱序
 */
@property (nonatomic, assign) BOOL                      isNumberKeyboardOrder;

@property (nonatomic, copy) keyBoardWillHideBlock   keyBordWillHideBlock;

@property (nonatomic, copy) keyBoardWillShowBlock   keyBordWillShowBlock;

/** 键盘类型:若不设置,将初始化系统键盘*/
- (void)setHybrideKeyBoardType:(HybrideKeyBoardType)safeKeyBoardType;

/** 禁止键盘类型:设置后，该类型键盘禁止切换*/
- (void)forbidKeyBoardType:(HybrideKeyBoardType)keyBoardType;

/** 监听block，当输入变化时*/
- (void)shouldChangeCharacters:(HbrideReturnBlock)returnBlock;
@end
