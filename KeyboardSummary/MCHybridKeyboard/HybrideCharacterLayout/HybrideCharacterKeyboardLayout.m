//
//  MCCharacterKeyboardView.m
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/22.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "HybrideCharacterKeyboardLayout.h"
#import "MCCharacterLabel.h"
#import "SoundAndShakeTool.h"

/*键盘背景颜色 */
#define kBackgroundColor RGBColor(26, 26, 26)
/*按钮普通背景颜色 */
#define kButtonNormalColor RGBColor(43, 43, 43)
/*按钮按下颜色 */
#define kButtonHighlightColor RGBColor(43, 150, 183)

/** 字母宽度 */
#define CharacterWidth (self.bounds.size.width - 9 * kColumnBetweenGap - 2 * kColumnLeftOrRightGap) / 10.f

/** 字母高度 */
#define CharacterHeighth (kMainKeyboardHeight - kRowBetweenGap * 4 - kRowTopOrBottomGap *2) / 5.f

/** 上下子layout高度 */
#define  CommonTopAndBottomLayoutHeight (CharacterHeighth + kRowTopOrBottomGap + kRowBetweenGap*0.5f)

/** 中间子layout高度 */
#define  CommonMiddleLayoutHeight (CharacterHeighth + kRowBetweenGap)

/** 字符键盘显示状态 */
typedef NS_ENUM(NSInteger, ShiftClickState) {
    ShiftClickStateDefault = 0,       //默认小写
    ShiftClickStateOnce,              //单击切换成大写
    ShiftClickStateDouble             //双击固定大写
};
/** 键盘总高度 */
static CGFloat const kMainKeyboardHeight = 270;
/** 键盘行间距 */
static CGFloat const kRowBetweenGap = 8.f;
/** 键盘列间距 */
static CGFloat const kColumnBetweenGap = 4.f;
/** 键盘行上下边距 */
static CGFloat const kRowTopOrBottomGap = 2.f;
/** 键盘列左右边距 */
static CGFloat const kColumnLeftOrRightGap = 3.f;

@interface HybrideCharacterKeyboardLayout ()
/** 小写字母键盘内容 */
@property (nonatomic, strong) NSMutableArray *lowerCharacterTitle;
/** 大写字母键盘内容 */
@property (nonatomic, strong) NSMutableArray *capitalCharacterTitle;
/** shift状态 */
@property (nonatomic, assign) ShiftClickState shiftClickState;
/** shift按钮 */
@property (nonatomic, weak)   UIButton *shiftButton;

@end


@implementation HybrideCharacterKeyboardLayout
- (void)dealloc {
    DLog(@"字母键盘消失");
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.backgroundColor = kBackgroundColor;
        self.orientation = MyOrientation_Vert;
        self.lowerCharacterTitle = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"shift",@"z",@"x",@"c",@"v",@"b",@"n",@"m",@"delete",@"*#.",@"空格",@"完成",nil];
        self.capitalCharacterTitle = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"SHIFT",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"DELETE",@"*#.",@"空格",@"完成",nil];
        _shiftClickState = ShiftClickStateDefault;
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
    firstRowLayout.myTop = 0;
    firstRowLayout.myHeight = CommonTopAndBottomLayoutHeight;
    firstRowLayout.myWidth =  self.bounds.size.width;
    
    // 第0排按钮
    for (int i = 0; i <= 9; i ++) {
        NSString *charcterStr = self.lowerCharacterTitle[i];
        
        MCCharacterLabel *characterLabel = [[MCCharacterLabel alloc] init];
        characterLabel.isLeftLabel = NO;
        characterLabel.isRightLabel = NO;
        characterLabel.myLeading = kColumnBetweenGap;
        characterLabel.myTop = kRowTopOrBottomGap;
        characterLabel.myWidth = CharacterWidth;
        characterLabel.myHeight = CharacterHeighth;
        if (i == 0) {
            characterLabel.isLeftLabel = YES;
            characterLabel.myLeading = kColumnLeftOrRightGap;
        }
        if (i == 9) {
            characterLabel.isRightLabel = YES;
        };
        characterLabel.text = charcterStr;
        characterLabel.tag = 700 + i;
        [firstRowLayout addSubview:characterLabel];
    }
    [self addSubview:firstRowLayout];
}

#pragma mark - firstRowLayout 第一排字母
- (void)addFirstRowLayout {
    MyLinearLayout *firstRowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    firstRowLayout.myLeading = 0;
    firstRowLayout.myTop = 0;
    firstRowLayout.myHeight = CommonMiddleLayoutHeight;
    firstRowLayout.myWidth =  self.bounds.size.width;
    
// 第一排按钮
    for (int i = 10; i <= 19; i ++) {
        NSString *charcterStr = self.lowerCharacterTitle[i];

        MCCharacterLabel *characterLabel = [[MCCharacterLabel alloc] init];
        characterLabel.isLeftLabel = NO;
        characterLabel.isRightLabel = NO;
        characterLabel.myLeading = kColumnBetweenGap;
        characterLabel.myTop = kRowBetweenGap * 0.5f;;
        characterLabel.myWidth = CharacterWidth;
        characterLabel.myHeight = CharacterHeighth;
        if (i == 10) {
            characterLabel.isLeftLabel = YES;
            characterLabel.myLeading = kColumnLeftOrRightGap;
        }
        if (i == 19) {
            characterLabel.isRightLabel = YES;
        };
        characterLabel.text = charcterStr;
        characterLabel.tag = 700 + i;
        [firstRowLayout addSubview:characterLabel];
    }
    [self addSubview:firstRowLayout];
}

#pragma mark - secondRowLayout 第二排字母
- (void)addSecondRowLayout {
    MyLinearLayout *secondRowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    secondRowLayout.myLeading = 0;
    secondRowLayout.myTop = 0;
    secondRowLayout.myWidth = self.bounds.size.width;
    secondRowLayout.myHeight = CommonMiddleLayoutHeight;
// 第二排按钮
    for (int i = 20; i <= 28; i ++) {
        NSString *charcterStr = self.lowerCharacterTitle[i];
        MCCharacterLabel *characterLabel = [[MCCharacterLabel alloc] init];
        characterLabel.myLeading = kColumnBetweenGap;
        characterLabel.myTop = kRowBetweenGap * 0.5f;;
        characterLabel.myWidth = CharacterWidth;
        characterLabel.myHeight = CharacterHeighth;
        if (i == 20) {
            characterLabel.myLeading = (secondRowLayout.myWidth - 8 *kColumnBetweenGap - 9 * CharacterWidth) / 2;
        }
        characterLabel.text = charcterStr;
        characterLabel.tag = 700 + i;
        [secondRowLayout addSubview:characterLabel];
    }
    [self addSubview:secondRowLayout];
}

#pragma mark - thirdRowLayout 第三排字母
- (void)addThirdRowLayout {
    MyLinearLayout *thirdRowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    thirdRowLayout.myLeading = 0;
    thirdRowLayout.myTop = 0;
    thirdRowLayout.myWidth = self.bounds.size.width;
    thirdRowLayout.myHeight = CommonMiddleLayoutHeight;
    
// shift按钮
    UIButton *shiftCharcterBtn = [[UIButton alloc] init];
    [shiftCharcterBtn setImage:[UIImage imageNamed:@"CharacterKeyBoard_Shift_Small"] forState:UIControlStateNormal];
    [shiftCharcterBtn setImage:[UIImage imageNamed:@"CharacterKeyBoard_Shift_Small_HightLight"] forState:UIControlStateHighlighted];
    [shiftCharcterBtn addTarget:self action:@selector(singleClikshiftButton) forControlEvents:UIControlEventTouchDown];
    [shiftCharcterBtn addTarget:self action:@selector(doubleClikshiftButton) forControlEvents:UIControlEventTouchDownRepeat];
    shiftCharcterBtn.myLeading = kColumnLeftOrRightGap;
    shiftCharcterBtn.myTop = kRowBetweenGap * 0.5f;;
    shiftCharcterBtn.myWidth = (thirdRowLayout.myWidth - 10 * kColumnBetweenGap - 7 *CharacterWidth) / 2.f;
    shiftCharcterBtn.myHeight = CharacterHeighth;
    [thirdRowLayout addSubview:shiftCharcterBtn];
    _shiftButton = shiftCharcterBtn;
// 第三排字母
    for (int i = 30; i <= 36; i ++) {
        NSString *charcterStr = self.lowerCharacterTitle[i];
        MCCharacterLabel *characterLabel = [[MCCharacterLabel alloc] init];
        characterLabel.myLeading = kColumnBetweenGap;
        characterLabel.myTop = kRowBetweenGap * 0.5f;
        characterLabel.myWidth = CharacterWidth;
        characterLabel.myHeight = CharacterHeighth;
                characterLabel.text = charcterStr;
        characterLabel.tag = 700 + i;
        [thirdRowLayout addSubview:characterLabel];
    }
// delete按钮
    UIButton *deleteCharcterBtn = [[UIButton alloc] init];
    [deleteCharcterBtn setImage:[UIImage imageNamed:@"CharacterKeyBoard_Back_Normal"] forState:UIControlStateNormal];
    [deleteCharcterBtn setImage:[UIImage imageNamed:@"CharacterKeyBoard_Back_TouchDown"] forState:UIControlStateHighlighted];
    [deleteCharcterBtn addTarget:self action:@selector(deleteCharacterBlock) forControlEvents:UIControlEventTouchUpInside];
    deleteCharcterBtn.myLeading = kColumnBetweenGap;
    deleteCharcterBtn.myTop = kRowBetweenGap * 0.5f;
    deleteCharcterBtn.myWidth = (thirdRowLayout.myWidth - 10 * kColumnBetweenGap - 7 *CharacterWidth) / 2.f;
    deleteCharcterBtn.myHeight = CharacterHeighth;
    [thirdRowLayout addSubview:deleteCharcterBtn];
    
    [self addSubview:thirdRowLayout];
}

#pragma mark - fourthRowLayout 第四排字母
- (void)addFourthRowLayout {
    MyLinearLayout *fourthRowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    fourthRowLayout.myLeading = 0;
    fourthRowLayout.myTop = 0;
    fourthRowLayout.myWidth = self.bounds.size.width;
    fourthRowLayout.myHeight = CommonTopAndBottomLayoutHeight;
    
// 切换到特殊字符键盘按钮
    for (int i = 38; i <= 40; i ++) {
        
        UIButton *characterButton = [[UIButton alloc] init]; 
        characterButton.layer.cornerRadius = 5.f;
        [characterButton setClipsToBounds:YES];
        [characterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [characterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        characterButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        characterButton.myLeading = kColumnBetweenGap;
        characterButton.myTop =  kRowBetweenGap * 0.5f;
        characterButton.myWidth = (fourthRowLayout.myWidth - 4 * kColumnBetweenGap) / 4.f;
        characterButton.myHeight = CharacterHeighth;
        // 切换到特殊字符键盘按钮
        if (i == 38) {
            characterButton.myLeading = kColumnLeftOrRightGap;
            [characterButton setBackgroundImage:[self imageWithColor:kButtonNormalColor] forState:UIControlStateNormal];
            [characterButton setTitle:self.lowerCharacterTitle[i] forState:UIControlStateNormal];
            [characterButton.titleLabel setFont:[UIFont systemFontOfSize:kSecutiryKeyboardTitleFont]];
            [self setLayerFeatures:characterButton];
            [characterButton addTarget:self action:@selector(changeToSpecialBlock) forControlEvents:UIControlEventTouchUpInside];
        }

        // 空格按钮
        if (i == 39) {
            [characterButton setImage:[UIImage imageNamed:@"CharacterKeyBoard_Space_Normal"] forState:UIControlStateNormal];
            [characterButton setImage:[UIImage imageNamed:@"CharacterKeyBoard_Space_TouchDown"] forState:UIControlStateHighlighted];
            [characterButton addTarget:self action:@selector(clickBlankSpaceBlock) forControlEvents:UIControlEventTouchUpInside];
            characterButton.myWidth = (fourthRowLayout.myWidth - 4 * kColumnBetweenGap) / 2.f;
        }
        // 完成按钮
        if (i == 40) {
            [characterButton setBackgroundImage:[self imageWithColor:kButtonNormalColor] forState:UIControlStateNormal];
            
            [characterButton setTitle:self.lowerCharacterTitle[i] forState:UIControlStateNormal];
            [characterButton.titleLabel setFont:[UIFont systemFontOfSize:kSecutiryKeyboardTitleFont]];
            [self setLayerFeatures:characterButton];
            [characterButton addTarget:self action:@selector(changeToNumberBlock) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [characterButton setBackgroundImage:[UIImage imageNamed:@"NumberKeyBoard_Number_TouchDown"] forState:UIControlStateHighlighted];
//        characterButton.myHeight = fourthRowLayout.myHeight - kRowBetweenGap * 2;
        [fourthRowLayout addSubview:characterButton];
    }
    
    [self addSubview:fourthRowLayout];
}
#pragma mark - 单击shift按钮
- (void)singleClikshiftButton {
    [SoundAndShakeTool play];
    // 小写切换大写
 if(_shiftClickState == ShiftClickStateDefault) {
      [_shiftButton setImage:[UIImage imageNamed:@"CharacterKeyBoard_Shift_Big"] forState:UIControlStateNormal];
    for (MyLinearLayout *linerLayout in self.subviews) {
        for (MCCharacterLabel *characterLabel in linerLayout.subviews) {
            if (characterLabel.tag >= 700) {
                NSInteger index = characterLabel.tag - 700;
                [characterLabel changeLabelString:self.capitalCharacterTitle[index]];
            }
        };
    }
     _shiftClickState = ShiftClickStateOnce;
     
     // 大写切换小写
 } else if(_shiftClickState == ShiftClickStateOnce || _shiftClickState == ShiftClickStateDouble) {
    [_shiftButton setImage:[UIImage imageNamed:@"CharacterKeyBoard_Shift_Small"] forState:UIControlStateNormal];
     for (MyLinearLayout *linerLayout in self.subviews) {
         for (MCCharacterLabel *characterLabel in linerLayout.subviews) {
              if (characterLabel.tag >= 700) {
                 NSInteger index = characterLabel.tag - 700;
                  [characterLabel changeLabelString:self.self.lowerCharacterTitle[index]];
         }
        }
     }
    _shiftClickState = ShiftClickStateDefault;
 }
}

#pragma mark - 双击shift按钮
- (void)doubleClikshiftButton {
    [SoundAndShakeTool play];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleClikshiftButton) object:nil];
    [_shiftButton setImage:[UIImage imageNamed:@"CharacterKeyBoard_Shift_BigFixed"] forState:UIControlStateNormal];
    for (MyLinearLayout *linerLayout in self.subviews) {
        for (MCCharacterLabel *characterLabel in linerLayout.subviews) {
            if (characterLabel.tag >= 700) {
                NSInteger index = characterLabel.tag - 700;
//                characterLabel.text = self.capitalCharacterTitle[index];
                [characterLabel changeLabelString:self.capitalCharacterTitle[index]];
            }
        };
    }
    _shiftClickState = ShiftClickStateDouble;

}

#pragma mark - 字母点击
- (void)clickCharacterBlock:(NSString *)characterStr {
    [SoundAndShakeTool play];
    if (self.characterKeyboardClikCharacterBlock) {
        self.characterKeyboardClikCharacterBlock(characterStr);
    }
    // 大写状态，点击字母后，回小写
    if (_shiftClickState == ShiftClickStateOnce) {
        [self singleClikshiftButton];
        _shiftClickState = ShiftClickStateDefault;
    }
}

- (void)getClickCharacterBlock:(CharacterKeyboardClikCharacterBlock)characterKeyboardClikCharacterBlock {
    _characterKeyboardClikCharacterBlock = characterKeyboardClikCharacterBlock;
}

#pragma mark - 删除点击
- (void)deleteCharacterBlock {
    [SoundAndShakeTool play];
    if (self.characterKeyboardDeleteCharacterBlock) {
        self.characterKeyboardDeleteCharacterBlock();
    }
}

- (void)getDeleteCharacterBlock:(CharacterKeyboardClikBlock)characterKeyboardDeleteCharacterBlock {
    _characterKeyboardDeleteCharacterBlock = characterKeyboardDeleteCharacterBlock;
}
#pragma mark - 空格点击
- (void)clickBlankSpaceBlock {
    [SoundAndShakeTool play];
    if (self.characterKeyboardClickBlankSpaceBlock) {
        self.characterKeyboardClickBlankSpaceBlock();
    }
}

- (void)getClickBlankSpaceBlock:(CharacterKeyboardClikBlock)characterKeyboardClickBlankSpaceBlock {
    _characterKeyboardClickBlankSpaceBlock = characterKeyboardClickBlankSpaceBlock;
}
#pragma mark - 切换到数字键盘
- (void)changeToNumberBlock {
    [SoundAndShakeTool play];
    if (self.characterKeyboardFinishBlock) {
        self.characterKeyboardFinishBlock();
    }
}
- (void)getFinishBlock:(CharacterKeyboardClikBlock)characterKeyboardFinishBlock {
    _characterKeyboardFinishBlock = characterKeyboardFinishBlock;
}

#pragma mark - 切换到特殊字符键盘
- (void)changeToSpecialBlock {
    [SoundAndShakeTool play];
    if (self.characterKeyboardToSpecialBlock) {
        self.characterKeyboardToSpecialBlock();
    }
}
- (void)getChangerToSpecialBlock:(CharacterKeyboardClikBlock)characterKeyboardToSpecialBlock {
    _characterKeyboardToSpecialBlock = characterKeyboardToSpecialBlock;
}

#pragma mark - 设置圆角以及边框特性
- (void)setLayerFeatures:(UIView *)view {
    view.layer.cornerRadius = 5.f;
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
            if ( characterLabel.tag >= 700) {
                if (CGRectContainsPoint(rect, point)) {
                    
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
            if ( characterLabel.tag >= 700) {
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
            if ( characterLabel.tag >= 700) {
                if (CGRectContainsPoint(rect, point)) {
//                    NSLog(@"%@",characterLabel.text);
                    [characterLabel notSeletedState];
                    [self clickCharacterBlock:characterLabel.text];
                } else {
//                    NSLog(@"不在范围");
                    [characterLabel notSeletedState];
                }
                
            }
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//     NSLog(@"取消");
     CGPoint point = [[touches anyObject] locationInView:self];
    for (MyLinearLayout *linerLayout in self.subviews) {
        
        for (MCCharacterLabel *characterLabel in linerLayout.subviews) {
            
            CGRect rect = [linerLayout convertRect:characterLabel.frame toView:self];
            if ( characterLabel.tag >= 700) {
                if (CGRectContainsPoint(rect, point)) {
//                    NSLog(@"%@",characterLabel.text);
                    [characterLabel notSeletedState];
                    
                }
                
                
            }
        }
    }
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
