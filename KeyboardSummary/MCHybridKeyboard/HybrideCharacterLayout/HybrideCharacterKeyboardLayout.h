//
//  MCCharacterKeyboardView.h
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/22.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "MyLinearLayout.h"

typedef void(^CharacterKeyboardClikCharacterBlock) (NSString *characterStr);
typedef void(^CharacterKeyboardClikBlock) (void);

@interface HybrideCharacterKeyboardLayout : MyLinearLayout
/**  点击字母block*/
@property (nonatomic, copy) CharacterKeyboardClikCharacterBlock characterKeyboardClikCharacterBlock;
/**  点击删除block*/
@property (nonatomic, copy) CharacterKeyboardClikBlock characterKeyboardDeleteCharacterBlock;
/**  点击空格block*/
@property (nonatomic, copy) CharacterKeyboardClikBlock characterKeyboardClickBlankSpaceBlock;
/**  点击切换到数字键盘block*/
@property (nonatomic, copy) CharacterKeyboardClikBlock characterKeyboardFinishBlock;
/**  点击切换到特殊字符键盘block*/
@property (nonatomic, copy) CharacterKeyboardClikBlock characterKeyboardToSpecialBlock;

- (void)getClickCharacterBlock:(CharacterKeyboardClikCharacterBlock)characterKeyboardClikCharacterBlock;

- (void)getDeleteCharacterBlock:(CharacterKeyboardClikBlock)characterKeyboardDeleteCharacterBlock;

- (void)getClickBlankSpaceBlock:(CharacterKeyboardClikBlock)characterKeyboardClickBlankSpaceBlock;

- (void)getFinishBlock:(CharacterKeyboardClikBlock)characterKeyboardFinishBlock;

- (void)getChangerToSpecialBlock:(CharacterKeyboardClikBlock)characterKeyboardToSpecialBlock;
@end
