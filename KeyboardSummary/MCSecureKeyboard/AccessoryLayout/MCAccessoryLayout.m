//
//  MCAccessoryLayout.m
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/23.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "MCAccessoryLayout.h"

 /*背景颜色 */
#define kAccessoryBackgroundColor RGBColor(34, 34, 34)
/*键盘顶部文字 */
#define kAccessoryTextColor RGBColor(120, 120, 120)

/**  整个键盘顶部的高度*/
static CGFloat const kAccessoryLayoutHeight = 39.f;
/**  整个键盘顶部的高度*/
static CGFloat const kTopLineHeight = .5f;
/**  键盘logo && 完成符合高度*/
static CGFloat const kLogoHeight = 25.f;
/**  键盘logo距离左侧的边距*/
static CGFloat const kLogoLeftGap = 5.f;
/**  键盘完成符号距离右侧的边距*/
static CGFloat const kFinishRightGap = 30.f;
/**  键盘完成符号高度*/
static CGFloat const kFinishHeight = 25.f;

@implementation MCAccessoryLayout
- (void)dealloc {
    DLog(@"顶部视图消失");
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.borderWidth = kTopLineHeight;
//        self.layer.borderColor = [ COMMON_LIGHT_GREY_COLOR CGColor];
        self.layer.backgroundColor = [kAccessoryBackgroundColor CGColor];
        self.orientation = MyOrientation_Horz;
        [self addTopAccessoryLayout];
    }
    
    return self;
}
#pragma mark - 添加子控件
- (void)addTopAccessoryLayout {
// logo
//    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Custom_KeyBoard_Logo_Icon"]];
//    logoImageView.myLeading = kLogoLeftGap;
//    logoImageView.myTop = (kAccessoryLayoutHeight - kLogoHeight) * 0.5f;
//    logoImageView.myWidth = kLogoHeight;
//    logoImageView.myHeight = kLogoHeight;
//    [self addSubview:logoImageView];
// 文字描述
    UILabel *keyboardDesLabel = [[UILabel alloc] init];
    keyboardDesLabel.backgroundColor = kAccessoryBackgroundColor;
    keyboardDesLabel.text = @"安全键盘";
    keyboardDesLabel.textColor = kAccessoryTextColor;
    keyboardDesLabel.font = [UIFont systemFontOfSize:kCommonSecutiryKeyboardSubtitleFont];
    keyboardDesLabel.textAlignment = NSTextAlignmentCenter;
     keyboardDesLabel.myLeading = 0;
    keyboardDesLabel.myTop = 0;
    keyboardDesLabel.myWidth = [UIScreen mainScreen].bounds.size.width;
    keyboardDesLabel.myHeight = kAccessoryLayoutHeight;
    [self addSubview:keyboardDesLabel];
// 收起按钮
    UIButton *finishButton = [[UIButton alloc] init];
    [finishButton setBackgroundImage:[self imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [finishButton setImage:[UIImage imageNamed:@"Custom_KeyBoard_Down_Icon"] forState:UIControlStateNormal];
    [finishButton setImage:[UIImage imageNamed:@"AccessoryView_Finish_TouchDown"] forState:UIControlStateHighlighted];
    [finishButton addTarget:self action:@selector(finishTap) forControlEvents:UIControlEventTouchUpInside];
    finishButton.myLeading = - kFinishRightGap - kFinishHeight;
        //增大点击范围
    finishButton.myWidth = kFinishHeight + kFinishRightGap;
    [finishButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    finishButton.myVertMargin = 0;
    [self addSubview:finishButton];
}
#pragma mark - 完成操作
- (void)finishTap {
    if (self.accessoryFinishClickBlock) {
        self.accessoryFinishClickBlock();
    }
}
- (void)getAccessoryFinishClickBlock:(AccessoryFinishClickBlock)accessoryFinishClickBlock {
    _accessoryFinishClickBlock = accessoryFinishClickBlock;
}
#pragma mark -  返回纯色背景
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
