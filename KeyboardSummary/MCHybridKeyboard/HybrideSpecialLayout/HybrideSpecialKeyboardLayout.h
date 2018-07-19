//
//  MCSpecialKeyboardLayout.h
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/31.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "MyLinearLayout.h"

typedef void(^SpecialKeyboardClikCharacterBlock) (NSString *specialStr);
typedef void(^SpecialKeyboardClikBlock) (void);

@interface HybrideSpecialKeyboardLayout : MyLinearLayout
/**  点击字母block*/
@property (nonatomic, copy) SpecialKeyboardClikCharacterBlock specialKeyboardClikCharacterBlock;
/**  点击删除block*/
@property (nonatomic, copy) SpecialKeyboardClikBlock specialKeyboardDeleteCharacterBlock;
/**  点击切换到数字键盘block*/
@property (nonatomic, copy) SpecialKeyboardClikBlock specialKeyboardFinishBlock;
/**  点击切换到字符键盘block*/
@property (nonatomic, copy) SpecialKeyboardClikBlock specialKeyboardToCharacterBlock;

- (void)getClickSpecialBlock:(SpecialKeyboardClikCharacterBlock)specialKeyboardClikCharacterBlock;

- (void)getDeleteSpecialBlock:(SpecialKeyboardClikBlock)specialKeyboardDeleteCharacterBlock;

- (void)getFinishBlock:(SpecialKeyboardClikBlock)specialKeyboardToNumberBlock;

- (void)getChangerToCharacterBlock:(SpecialKeyboardClikBlock)specialKeyboardToCharacterBlock;
@end
