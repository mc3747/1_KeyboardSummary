//
//  MCNumberKeyboardTextView.h
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/9.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCPasswordKeyboardTextView;

typedef void(^MCNumberPasswordKeyboardBlock)(MCPasswordKeyboardTextView *textView, NSString *inputString,BOOL isClick);

@interface MCPasswordKeyboardTextView : UIView
/**1，初始化：已知尺寸，可以设置改属性  */
- (void)setCurrentView:(UIView *)curView;

/**2，未知尺寸，统一初始化*/
- (instancetype)initWithFrame:(CGRect)frame inView:(UIView *)curView;

/**1，属性监听输入*/
@property (nonatomic, copy) MCNumberPasswordKeyboardBlock   returnBlock;

/**2，方法监听*/
- (void)shouldChangeNumbers:(MCNumberPasswordKeyboardBlock )returnBlock;

/**  退出键盘*/
- (void)keyBoardResignFirstResponder;

/**  调出键盘*/
- (void)keyBoardBecomeFirstResponder;

@end
