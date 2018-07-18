//
//  MCSpecialKeyboardLayout.m
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/31.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "HybrideSpecialKeyboardLayout.h"
#import "MCCharacterLabel.h"
#import "SoundAndShakeTool.h"
/** 键盘总高度 */
static CGFloat const kMainKeyboardHeight = 270;
/** 键盘行间距 */
static CGFloat const kRowBetweenGap = 4.f;
/** 键盘列间距 */
static CGFloat const kColumnBetweenGap = 4.f;
/** 键盘行上下边距 */
static CGFloat const kRowTopOrBottomGap = 3.f;
/** 键盘列左右边距 */
static CGFloat const kColumnLeftOrRightGap = 3.f;
/** 每个子layout高度 */
static CGFloat const kSubLayoutHeighth = kMainKeyboardHeight / 5.f;
/** 背景通用颜色 */
#define CommonBackgroundColor [UIColor colorWithRed:208/256.f green:216/256.f blue:226/256.f alpha:1.f]
/** 特殊字符按钮宽度 */
#define CommonSpecialCharaterWidth (self.bounds.size.width - 9 * kColumnBetweenGap - kRowTopOrBottomGap - kColumnLeftOrRightGap) / 10.f
/** 特殊字符按钮高度 */
#define CommonSpecialCharaterHeighth (kSubLayoutHeighth - kRowTopOrBottomGap *2)
/** 删除||切换数字||切换字母按钮宽度 */
#define CommonDeleteButtonHeighth  (self.bounds.size.width - 8 * kColumnBetweenGap - 7*CommonSpecialCharaterWidth - 2 * kColumnLeftOrRightGap) / 2.f

@interface HybrideSpecialKeyboardLayout()
/** 特殊字符键盘内容 */
@property (nonatomic, strong) NSMutableArray *specialCharacterTitle;

@end

@implementation HybrideSpecialKeyboardLayout

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CommonBackgroundColor;
        self.orientation = MyOrientation_Vert;
        self.specialCharacterTitle = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"!",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",
                                      @"'",@"\"",@"=",@"_",@":",@";",@"?",@"~",@"|",@"•",
                                      @"+",@"-",@"\\",@"/",@"[",@"]",@"{",@"}",@"delete",
                                      @"ABC",@",",@".",@"<",@">",@"€",@"£",@"¥",@"确定",nil];
        [self addSubLayouts];
    }
    return self;
}
#pragma mark - 添加子控件
- (void)addSubLayouts {
    [self addZeroRowLayout];
    [self addFirstRowLayout];
    [self addSecondRowLayout];
    [self addThirdRowLayout];
    [self addFourthRowLayout];
}
#pragma mark -zeroRowLayout 第0排字母
- (void)addZeroRowLayout {
    MyLinearLayout *firstRowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    firstRowLayout.myLeading = 0;
    firstRowLayout.myTop =  1;
    firstRowLayout.myHeight = kSubLayoutHeighth;
    firstRowLayout.myWidth =  self.bounds.size.width;
    
    // 第一排按钮
    for (int i = 0; i <= 9; i ++) {
        NSString *charcterStr = self.specialCharacterTitle[i];
        MCCharacterLabel *characterLabel = [[MCCharacterLabel alloc] init];
        characterLabel.isLeftLabel = NO;
        characterLabel.isRightLabel = NO;
        characterLabel.myLeading = kColumnBetweenGap;
        characterLabel.myTop = kRowTopOrBottomGap;
        characterLabel.myWidth =CommonSpecialCharaterWidth;
        characterLabel.myHeight = CommonSpecialCharaterHeighth;
        if (i == 0) {
            characterLabel.isLeftLabel = YES;
            characterLabel.myLeading = kColumnLeftOrRightGap;
        }
        if (i == 9) {
            characterLabel.isRightLabel = YES;
        }
        characterLabel.text = charcterStr;
        characterLabel.tag = 800 + i;
        [firstRowLayout addSubview:characterLabel];
    }
    [self addSubview:firstRowLayout];
}
#pragma mark - firstRowLayout 第一排特殊字符
- (void)addFirstRowLayout {
    MyLinearLayout *firstRowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    firstRowLayout.myLeading = 0;
    firstRowLayout.myTop =  1;//
    firstRowLayout.myHeight = kSubLayoutHeighth;
    firstRowLayout.myWidth =  self.bounds.size.width;
    
    // 第一排按钮
    for (int i = 10; i <= 19; i ++) {
        NSString *charcterStr = self.specialCharacterTitle[i];
        MCCharacterLabel *characterLabel = [[MCCharacterLabel alloc] init];
        characterLabel.isLeftLabel = NO;
        characterLabel.isRightLabel = NO;
        characterLabel.myLeading = kColumnBetweenGap;
        characterLabel.myTop = kRowTopOrBottomGap;
        characterLabel.myWidth =CommonSpecialCharaterWidth;
        characterLabel.myHeight = CommonSpecialCharaterHeighth;
        if (i == 10) {
            characterLabel.isLeftLabel = YES;
            characterLabel.myLeading = kColumnLeftOrRightGap;
        }
        if (i == 19) {
            characterLabel.isRightLabel = YES;
        }
        characterLabel.text = charcterStr;
        characterLabel.tag = 800 + i;
        [firstRowLayout addSubview:characterLabel];
    }
    [self addSubview:firstRowLayout];
}

#pragma mark - secondRowLayout 第二排特殊字符
- (void)addSecondRowLayout {
    MyLinearLayout *secondRowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    secondRowLayout.myLeading = 0;
    secondRowLayout.myTop = 0;
    secondRowLayout.myWidth = self.bounds.size.width;
    secondRowLayout.myHeight = kSubLayoutHeighth;
    // 第二排按钮
    for (int i = 20; i <= 29; i ++) {
        NSString *charcterStr = self.specialCharacterTitle[i];
        MCCharacterLabel *characterLabel = [[MCCharacterLabel alloc] init];
        characterLabel.isLeftLabel = NO;
        characterLabel.isRightLabel = NO;
        characterLabel.myLeading = kColumnBetweenGap;
        characterLabel.myTop = kRowBetweenGap * 0.5f;
        characterLabel.myWidth = CommonSpecialCharaterWidth;
        characterLabel.myHeight = CommonSpecialCharaterHeighth;
        if (i == 20) {
            characterLabel.isLeftLabel = YES;
            characterLabel.myLeading = kColumnLeftOrRightGap;
        }
        if (i == 29) {
            characterLabel.isRightLabel = YES;
        }
        characterLabel.text = charcterStr;
        characterLabel.tag = 800 + i;
        [secondRowLayout addSubview:characterLabel];
    }
    [self addSubview:secondRowLayout];
}

#pragma mark - thirdRowLayout 第三排特殊字符
- (void)addThirdRowLayout {
    MyLinearLayout *thirdRowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    thirdRowLayout.myLeading = 0;
    thirdRowLayout.myTop = 0;
    thirdRowLayout.myWidth = self.bounds.size.width;
    thirdRowLayout.myHeight = kSubLayoutHeighth;

    
    // 第三排字母
    for (int i = 30; i <= 37; i ++) {
        NSString *charcterStr = self.specialCharacterTitle[i];
        MCCharacterLabel *characterLabel = [[MCCharacterLabel alloc] init];
        characterLabel.myLeading = kColumnBetweenGap;
        characterLabel.myTop = kRowBetweenGap * 0.5f;
        characterLabel.myWidth = CommonSpecialCharaterWidth;
        characterLabel.myHeight = CommonSpecialCharaterHeighth;
        if (i == 30) {
              characterLabel.myLeading = self.bounds.size.width - 8 * CommonSpecialCharaterWidth - 8 * kColumnBetweenGap - CommonDeleteButtonHeighth - kColumnLeftOrRightGap;
        }
        characterLabel.text = charcterStr;
        characterLabel.tag = 800 + i;
        [thirdRowLayout addSubview:characterLabel];
    }
    // delete按钮
    UIButton *deleteCharcterBtn = [[UIButton alloc] init];
    [deleteCharcterBtn setImage:[UIImage imageNamed:@"CharacterKeyBoard_Back_Normal"] forState:UIControlStateNormal];
    [deleteCharcterBtn setImage:[UIImage imageNamed:@"CharacterKeyBoard_Back_TouchDown"] forState:UIControlStateHighlighted];
    [deleteCharcterBtn addTarget:self action:@selector(deleteCharacterBlock) forControlEvents:UIControlEventTouchUpInside];
    deleteCharcterBtn.myLeading = kColumnBetweenGap;
    deleteCharcterBtn.myTop = kRowBetweenGap * 0.5f;
    deleteCharcterBtn.myWidth = CommonDeleteButtonHeighth;
    deleteCharcterBtn.myHeight = CommonSpecialCharaterHeighth;
    [thirdRowLayout addSubview:deleteCharcterBtn];
    
    [self addSubview:thirdRowLayout];
}

#pragma mark - thirdRowLayout 第四排特殊字符
- (void)addFourthRowLayout {
    MyLinearLayout *fourthRowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    fourthRowLayout.myLeading = 0;
    fourthRowLayout.myTop = 0;
    fourthRowLayout.myWidth = self.bounds.size.width;
    fourthRowLayout.myHeight = kSubLayoutHeighth;
    // 切换到字母键盘按钮
    UIButton *toCharacterButton = [[UIButton alloc] init];
    toCharacterButton.myLeading = kColumnBetweenGap;
    toCharacterButton.myTop = kRowBetweenGap * 0.5f;
    toCharacterButton.myWidth = CommonDeleteButtonHeighth;
    toCharacterButton.myHeight = CommonSpecialCharaterHeighth;
    [toCharacterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [toCharacterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    toCharacterButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [toCharacterButton.titleLabel setFont:[UIFont systemFontOfSize:kSecutiryKeyboardTitleFont]];
    [self setLayerFeatures:toCharacterButton];
    [toCharacterButton setBackgroundImage:[UIImage imageNamed:@"NumberKeyBoard_Number_TouchDown"] forState:UIControlStateHighlighted];
    [toCharacterButton setTitle:self.specialCharacterTitle[39] forState:UIControlStateNormal];
    [toCharacterButton addTarget:self action:@selector(changeToCharcterBlock) forControlEvents:UIControlEventTouchUpInside];
    [fourthRowLayout addSubview:toCharacterButton];
    
    // 第四排特殊字符
    for (int i = 40; i <= 46; i ++) {
        NSString *charcterStr = self.specialCharacterTitle[i];
        MCCharacterLabel *characterLabel = [[MCCharacterLabel alloc] init];
        characterLabel.myLeading = kColumnBetweenGap;
        characterLabel.myTop = kRowBetweenGap * 0.5f;
        characterLabel.myWidth = CommonSpecialCharaterWidth;
        characterLabel.myHeight = CommonSpecialCharaterHeighth;
        characterLabel.text = charcterStr;
        characterLabel.tag = 800 + i;
        [fourthRowLayout addSubview:characterLabel];
    }
    // 切换到数字键盘按钮
    UIButton *toNumberButton = [[UIButton alloc] init];
    toNumberButton.myLeading = kColumnLeftOrRightGap;
    toNumberButton.myTop = kRowBetweenGap * 0.5f;
    toNumberButton.myWidth = CommonDeleteButtonHeighth;
    toNumberButton.myHeight = CommonSpecialCharaterHeighth;
    [toNumberButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [toNumberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    toNumberButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [toNumberButton.titleLabel setFont:[UIFont systemFontOfSize:kSecutiryKeyboardTitleFont]];
    [self setLayerFeatures:toNumberButton];
    [toNumberButton setBackgroundImage:[UIImage imageNamed:@"NumberKeyBoard_Number_TouchDown"] forState:UIControlStateHighlighted];
    [toNumberButton setTitle:self.specialCharacterTitle[47] forState:UIControlStateNormal];
    [toNumberButton addTarget:self action:@selector(changeToNumberBlock) forControlEvents:UIControlEventTouchUpInside];
    [fourthRowLayout addSubview:toNumberButton];
    
    
     [self addSubview:fourthRowLayout];
}
#pragma mark - 特殊字符点击
- (void)clickSpecialBlock:(NSString *)specialStr {
    [SoundAndShakeTool play];
    if (self.specialKeyboardClikCharacterBlock) {
        self.specialKeyboardClikCharacterBlock(specialStr);
    }
}

- (void)getClickSpecialBlock:(SpecialKeyboardClikCharacterBlock)specialKeyboardClikCharacterBlock {
    _specialKeyboardClikCharacterBlock = specialKeyboardClikCharacterBlock;
}
#pragma mark - delete按钮点击
- (void)deleteCharacterBlock {
    [SoundAndShakeTool play];
    if (self.specialKeyboardDeleteCharacterBlock) {
        self.specialKeyboardDeleteCharacterBlock();
    }
}

- (void)getDeleteSpecialBlock:(SpecialKeyboardClikBlock)specialKeyboardDeleteCharacterBlock {
    _specialKeyboardDeleteCharacterBlock = specialKeyboardDeleteCharacterBlock;
}

#pragma mark - 切换到字母键盘按钮点击
- (void)changeToNumberBlock {
    [SoundAndShakeTool play];
    if (self.specialKeyboardToNumberBlock) {
        self.specialKeyboardToNumberBlock();
    }
}

- (void)getChangerToNumberBlock:(SpecialKeyboardClikBlock)specialKeyboardToNumberBlock {
    _specialKeyboardToNumberBlock = specialKeyboardToNumberBlock;
}
#pragma mark - 切换到数字键盘按钮点击
- (void)changeToCharcterBlock {
    [SoundAndShakeTool play];
    if (self.specialKeyboardToCharacterBlock) {
        self.specialKeyboardToCharacterBlock();
    }
}
- (void)getChangerToCharacterBlock:(SpecialKeyboardClikBlock)specialKeyboardToCharacterBlock {
    _specialKeyboardToCharacterBlock = specialKeyboardToCharacterBlock;
}
#pragma mark - 设置圆角以及边框特性
- (void)setLayerFeatures:(UIView *)view {
    view.layer.cornerRadius = 5.f;
    view.layer.backgroundColor = CommonBackgroundColor.CGColor;
    view.layer.borderWidth = 0.5f;
    view.layer.borderColor = [UIColor colorWithRed:94/255.0 green:98/255.0 blue:99/255.0 alpha:1.0].CGColor;
}
#pragma mark - 触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"开始");
    CGPoint point = [[touches anyObject] locationInView:self];
    for (MyLinearLayout *linerLayout in self.subviews) {
        
        for (MCCharacterLabel *characterLabel in linerLayout.subviews) {
            
            CGRect rect = [linerLayout convertRect:characterLabel.frame toView:self];
            if ( characterLabel.tag >= 800) {
                if (CGRectContainsPoint(rect, point)) {
//                    NSLog(@"%@",characterLabel.text);
                    
                    [characterLabel selectedState];
                } else {
                    [characterLabel notSeletedState];
                }
            }
            
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"移动");
    CGPoint point = [[touches anyObject] locationInView:self];
    
    for (MyLinearLayout *linerLayout in self.subviews) {
        
        for (MCCharacterLabel *characterLabel in linerLayout.subviews) {
            
            CGRect rect = [linerLayout convertRect:characterLabel.frame toView:self];
            if ( characterLabel.tag >= 800) {
                if (CGRectContainsPoint(rect, point)) {
//                    NSLog(@"%@",characterLabel.text);
                    [characterLabel selectedState];
                } else {
                    [characterLabel notSeletedState];
                }
            }
        }
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"结束");
    CGPoint point = [[touches anyObject] locationInView:self];
    for (MyLinearLayout *linerLayout in self.subviews) {
        for (MCCharacterLabel *characterLabel in linerLayout.subviews) {
            
            CGRect rect = [linerLayout convertRect:characterLabel.frame toView:self];
            if ( characterLabel.tag >= 800) {
                if (CGRectContainsPoint(rect, point)) {
//                    NSLog(@"%@",characterLabel.text);
                    [characterLabel notSeletedState];
                    [self clickSpecialBlock:characterLabel.text];
                } else {
//                    NSLog(@"不在范围");
                    [characterLabel notSeletedState];
                }
                
            }
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"取消");
    CGPoint point = [[touches anyObject] locationInView:self];
    for (MyLinearLayout *linerLayout in self.subviews) {
        
        for (MCCharacterLabel *characterLabel in linerLayout.subviews) {
            
            CGRect rect = [linerLayout convertRect:characterLabel.frame toView:self];
            if ( characterLabel.tag >= 800) {
                if (CGRectContainsPoint(rect, point)) {
//                    NSLog(@"%@",characterLabel.text);
                    
                    [characterLabel notSeletedState];
                    
                }
                
            }
        }
    }
}
@end
