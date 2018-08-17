//
//  MCNumberKeyboardLayout.h
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/25.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "MyLinearLayout.h"

typedef void(^NumberKeyboardClickInputBlock) (NSString *numberStr);

typedef void(^NumberKeyboardClickNonInputBlock)(void);

/*键盘view类型 */
typedef NS_ENUM(NSInteger, NumberKeyboardStyle) {
    NumberKeyboardStyleDefault  = 40000,        //textfield：正常显示；键盘：数字顺序 + 无
    NumberKeyboardStyleDelete  = 40001,        //textfield：正常显示；键盘：数字顺序 + 清除
    NumberKeyboardStylePoint   = 40002,        //textfield：正常显示；键盘：数字顺序 + 小数点
    NumberKeyboardStyleX       = 40003         //textfield：正常显示；键盘：数字顺序 + X
};

@interface MCNewNumberKeyboardLayout : MyLinearLayout

/**点击了数字 */
@property (nonatomic, copy) NumberKeyboardClickInputBlock clickNumberBlock;

/**点击了小数点 */
@property (nonatomic, copy) NumberKeyboardClickInputBlock clickDotBlock;

/**点击了X字母 */
@property (nonatomic, copy) NumberKeyboardClickInputBlock clickXBlock;

/**点击了删除 */
@property (nonatomic, copy) NumberKeyboardClickNonInputBlock clickDeleteBlock;

/**点击了全部删除 */
@property (nonatomic, copy) NumberKeyboardClickNonInputBlock clickTotalDeleteBlock;

/**数字键盘是否乱序，yes为顺序；no为打乱 */
@property (nonatomic, assign) BOOL isNumberKeyboardOrder;

/**键盘类型 */
@property (nonatomic, assign) NumberKeyboardStyle keyboardStyle;

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame andStyle:(NumberKeyboardStyle)keyboardStyle andOrder:(BOOL)isNumberKeyboardOrder;

//回调方法
- (void)getClickNumberBlock:(NumberKeyboardClickInputBlock )clickNumberBlock;
- (void)getClickDotBlock:(NumberKeyboardClickInputBlock )clickDotBlock;
- (void)getClickXBlock:(NumberKeyboardClickInputBlock )clickXBlock;
- (void)getClickDeleteBlock:(NumberKeyboardClickNonInputBlock )clickDeleteBlock;
- (void)getClickTotalDeleteBlock:(NumberKeyboardClickNonInputBlock )clickTotalDeleteBlock;

/*激活身份证的X按钮 */
- (void)activeButtonX;

/*取消激活身份证的X按钮 */
- (void)nonActiveButtonX;

/*激活数字按钮 */
- (void)activeNumberButton;

/*取消激活数字按钮 */
- (void)nonActiveNumberButton;

@end
