//
//  MCCharacterLabel.h
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/18.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCCharacterLabel : UILabel
/*是否隐藏大label*/
@property (nonatomic, assign) BOOL isHidBigLabel;
/*是否是最左侧label*/
@property (nonatomic, assign) BOOL isLeftLabel;
/*是否是最右侧label*/
@property (nonatomic, assign) BOOL isRightLabel;
/*选中状态*/
- (void)selectedState;
/*未选中状态*/
- (void)notSeletedState;
/*更新显示字符*/
- (void)changeLabelString:(NSString *)labelString;
@end
