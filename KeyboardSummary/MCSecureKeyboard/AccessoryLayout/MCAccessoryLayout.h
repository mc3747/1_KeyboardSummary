//
//  MCAccessoryLayout.h
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/23.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "MyLinearLayout.h"

typedef void(^AccessoryFinishClickBlock) ();

@interface MCAccessoryLayout : MyLinearLayout
/**  点击收起键盘小箭头block*/
@property (nonatomic, copy) AccessoryFinishClickBlock accessoryFinishClickBlock;
- (void)getAccessoryFinishClickBlock:(AccessoryFinishClickBlock)accessoryFinishClickBlock;
@end
