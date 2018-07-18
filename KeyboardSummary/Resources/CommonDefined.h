//
//  CommonDefined.h
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/6.
//  Copyright © 2018年 macheng. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef CommonDefined_h
#define CommonDefined_h

#define DLog(fmt, ...) printf("%s [Line %d] %s  \n",__PRETTY_FUNCTION__, __LINE__,[[NSString stringWithFormat:(fmt), ##__VA_ARGS__] UTF8String]);

//  颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define COMMON_LIGHT_GREY_COLOR RGBColor(206, 206, 206)
#define COMMON_BLACK_COLOR RGBColor(94, 98, 99)
#define COMMON_GREY_COLOR RGBColor(163, 163, 163)
#define COMMON_BLUE_GREEN_COLOR RGBColor(51, 167, 196)
// 安全键盘字体大小
static CGFloat const kSecutiryKeyboardTitleFont = 20.0f;
static CGFloat const kCommonSecutiryKeyboardSubtitleFont = 15.0f;
static CGFloat const kCommonSecutiryKeyboardLargeLabelFont = 35.0f;

//  屏幕大小
#define MAIN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// iphonex安全距离
#define IPHONE_X_Top_SafeArea_Height  (IS_IPHONE_X == YES ? 44 : 0)
#define IPHONE_X_Top_Normal_Height  (IS_IPHONE_X == YES ? 24 : 0)
#define IPHONE_X_Bottom_SafeArea_Height  (IS_IPHONE_X == YES ? 34 : 0)
#define IS_IPHONE_X (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// weakSelf和strongSelf
#define GJWeakSelf  __weak typeof(self) weakSelf = self;
#define GJStrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;

#endif /* CommonDefined_h */
