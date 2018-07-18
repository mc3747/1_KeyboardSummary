//
//  MCNumberKeyboardLayout.h
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/25.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "MyLinearLayout.h"

typedef void(^NumberKeyboardClikNumberBlock) (NSString *numberStr);
typedef void(^NumberKeyboardClikBlock)(void);

@interface MCNumberKeyboardLayout : MyLinearLayout
/** 点击了数字键盘数字按钮 */
@property (nonatomic, copy) NumberKeyboardClikNumberBlock numberKeyboardClikNumberBlock;
/** 点击了数字键盘删除按钮 */
@property (nonatomic, copy) NumberKeyboardClikBlock numberKeyboardClikDeleteBlock;
/** 点击了切换成字母键盘按钮 */
@property (nonatomic, copy) NumberKeyboardClikBlock numberKeyboardClikToCharacterBlock;
/** 数字键盘是否乱序，yes为顺序；no为打乱 */
@property (nonatomic, assign) BOOL isNumberKeyboardOrder;


- (void)getClikNumberBlock:(NumberKeyboardClikNumberBlock )numberKeyboardClikNumberBlock;
- (void)getClikDeleteBlock:(NumberKeyboardClikBlock )numberKeyboardClikDeleteBlock;
- (void)getClikToCharacterBlock:(NumberKeyboardClikBlock )numberKeyboardClikToCharacterBlock;
@end
