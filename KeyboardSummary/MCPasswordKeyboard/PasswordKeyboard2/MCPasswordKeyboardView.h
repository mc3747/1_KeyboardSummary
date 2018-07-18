//
//  SecurityNumberKeyBoardView.h
//  HX_GJS
//
//  Created by gjfax on 16/2/1.
//  Copyright © 2016年 GjFax. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GJS_KeyBoard_DownView_Noti      @"GJS_KeyBoard_DownView_Noti"

 /*键盘view类型 */
typedef NS_ENUM(NSInteger, NumberKeyboardStyle) {
    NumberKeyboardStyleDisorder     = 30000,        //textfield：黑圆圈显示；键盘：数字乱序 + 清除
    
    NumberKeyboardStyleOrderDelete  = 30001,        //textfield：正常显示；键盘：数字顺序 + 清除
    NumberKeyboardStyleOrderPoint   = 30002,        //textfield：正常显示；键盘：数字顺序 + 小数点
    NumberKeyboardStyleOrderX       = 30003         //textfield：正常显示；键盘：数字顺序 + X
};

 /*键盘view输入回调类型 */
typedef NS_ENUM(NSInteger, ReturnBlockType) {
    ReturnBlockTypeDefuatl      =   20000,      //数字 &点 &X 输入
    ReturnBlockTypeClearAll     =   20001,      //清除所有
    ReturnBlockTypeClearOne     =   20002,      //清除一位
};

typedef void(^KeyBoarReturnBlock)(NSString *textString, ReturnBlockType type);
typedef void(^KeyBoarFinishBlock)(void);
@interface MCPasswordKeyboardView : UIView

/**  输入回调*/
@property (nonatomic, copy) KeyBoarReturnBlock      returnBlock;
/**  顶部完成回调*/
@property (nonatomic, copy) KeyBoarFinishBlock      finishBlock;
/**  键盘view的类型*/
@property (nonatomic, assign) NumberKeyboardStyle   numberKeyboardStyle;

/**  弹出键盘（仅仅密码键盘使用）*/
- (void)showInView:(UIView *)view;

/**  隐藏键盘（仅仅密码键盘使用）*/
- (void)downInView;

/**  默认初始化：数字乱序 + 清除*/
- (instancetype)initWithFrame:(CGRect)frame;

/**  键盘类型初始化*/
- (instancetype)initWithFrame:(CGRect)frame andStyle:(NumberKeyboardStyle)numberKeyboardStyle;

/*激活身份证的X按钮 */
- (void)activeButtonX;

/*取消激活身份证的X按钮 */
- (void)nonActiveButtonX;

@end
