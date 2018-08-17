//
//  MCNumberKeyboardLayout.m
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/25.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "MCNewNumberKeyboardLayout.h"
#import "SoundAndShakeTool.h"
#import "MCCharacterLabel.h"

/*键盘背景颜色 */
#define kBackgroundColor RGBColor(26, 26, 26)
/*键盘顶部文字 */
#define kAccessoryTextColor RGBColor(120, 120, 120)
/*按钮背景颜色 */
#define kButtonNormalColor RGBColor(57, 57, 57)
/*按钮按下颜色 */
#define kButtonHighlightColor RGBColor(43, 150, 183)
/*按钮按下阴影的颜色 */
#define kButtonShadowColor RGBColor(65, 124, 143)

/** 键盘行边距&&列边距 */
static CGFloat const kButtonToSuperGap = 3.f;
/** 键盘按钮行间距&&列间距 */
static CGFloat const kButtonBetweenGap = 4.f;
/** 键盘主体高度 */
static CGFloat const kMainKeyboardHeight = 216;
/** 每个子layout高度 */
static CGFloat const kSubLayoutHeighth = 216 / 4.f;

/** 数字按钮宽度 */
#define CommonButtonWidth ([UIScreen mainScreen].bounds.size.width - 2 *(kButtonToSuperGap + kButtonBetweenGap)) / 3.f
/** 数字按钮高度 */
#define CommonButtonHeight (kMainKeyboardHeight - 3*kButtonToSuperGap - 2*kButtonBetweenGap)/4.f


@interface MCNewNumberKeyboardLayout ()
@property(nonatomic,strong)NSMutableArray *numberArray;
@property (nonatomic, strong) UIButton *leftBottomButton;
@property (nonatomic, assign) BOOL isNotActive;
@end
@implementation MCNewNumberKeyboardLayout
- (void)dealloc {
    DLog(@"数字键盘消失");
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame andStyle:(NumberKeyboardStyle)keyboardStyle andOrder:(BOOL)isNumberKeyboardOrder {
    self = [super initWithFrame:frame];
    if (self) {
        _keyboardStyle = keyboardStyle;
        _isNumberKeyboardOrder = isNumberKeyboardOrder;
        self.backgroundColor = kBackgroundColor;
        self.orientation = MyOrientation_Vert;
        if (_isNumberKeyboardOrder) {
            self.numberArray = [self getOrderArray];
        } else {
            self.numberArray = [self getRandomArray];
        };
        [self addFirstRowLayout];
        [self addSecondRowLayout];
        [self addThirdRowLayout];
        [self addFourthRowLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = kBackgroundColor;
        self.orientation = MyOrientation_Vert;
        [self addFirstRowLayout];
        [self addSecondRowLayout];
        [self addThirdRowLayout];
        [self addFourthRowLayout];
    }
    return self;
}

#pragma mark - 是否乱序
- (void)setIsNumberKeyboardOrder:(BOOL)isNumberKeyboardOrder
{
    if (isNumberKeyboardOrder) {
        self.numberArray = [self getOrderArray];
        [self removeAllSubviews];
        [self addFirstRowLayout];
        [self addSecondRowLayout];
        [self addThirdRowLayout];
        [self addFourthRowLayout];
    }
}
#pragma mark -  键盘风格
- (void)setKeyboardStyle:(NumberKeyboardStyle)keyboardStyle {
    _keyboardStyle = keyboardStyle;
    [self removeAllSubviews];
    [self addFirstRowLayout];
    [self addSecondRowLayout];
    [self addThirdRowLayout];
    [self addFourthRowLayout];
}
#pragma mark - firstRowLayout 第一排数字
- (void)addFirstRowLayout {
    MyLinearLayout *firstRowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    firstRowLayout.myLeading = 0;
    firstRowLayout.myTop = 0;
    firstRowLayout.myHeight = kSubLayoutHeighth;
    firstRowLayout.myWidth =  self.bounds.size.width;
    // 第一排按钮
    for (int i = 0; i <= 2; i ++) {
        NSString *charcterStr = self.numberArray[i];
        MCCharacterLabel *characterLabel = [[MCCharacterLabel alloc] init];
        characterLabel.isHidBigLabel = YES;
        characterLabel.myLeading = kButtonBetweenGap;
        characterLabel.myTop = kButtonToSuperGap;
        characterLabel.myWidth = CommonButtonWidth;
        characterLabel.myHeight = CommonButtonHeight;
        characterLabel.text = charcterStr;
        characterLabel.tag = 600 + i;
        [firstRowLayout addSubview:characterLabel];
    }
    [self addSubview:firstRowLayout];
}
#pragma mark - secondRowLayout 第二排数字
- (void)addSecondRowLayout {
    MyLinearLayout *secondRowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    secondRowLayout.myLeading = 0;
    secondRowLayout.myTop = 0;
    secondRowLayout.myWidth = self.bounds.size.width;
    secondRowLayout.myHeight = kSubLayoutHeighth;
    // 第二排按钮
    for (int i = 3; i <= 5; i ++) {
        NSString *charcterStr = self.numberArray[i];
        MCCharacterLabel *characterLabel = [[MCCharacterLabel alloc] init];
        characterLabel.isHidBigLabel = YES;
        characterLabel.myLeading = kButtonBetweenGap;
        characterLabel.myTop = kButtonToSuperGap;
        characterLabel.myWidth = CommonButtonWidth;
        characterLabel.myHeight = CommonButtonHeight;
        characterLabel.text = charcterStr;
        characterLabel.tag = 600 + i;
        [secondRowLayout addSubview:characterLabel];
    }
    [self addSubview:secondRowLayout];
    
}
#pragma mark - thirdRowLayout 第三排数字
- (void)addThirdRowLayout {
    MyLinearLayout *thirdRowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    thirdRowLayout.myLeading = 0;
    thirdRowLayout.myTop = 0;
    thirdRowLayout.myWidth = self.bounds.size.width;
    thirdRowLayout.myHeight = kSubLayoutHeighth;
    // 第三排按钮
    for (int i = 6; i <= 8; i ++) {
        NSString *charcterStr = self.numberArray[i];
        MCCharacterLabel *characterLabel = [[MCCharacterLabel alloc] init];
        characterLabel.isHidBigLabel = YES;
        characterLabel.myLeading = kButtonBetweenGap;
        characterLabel.myTop = kButtonToSuperGap;
        characterLabel.myWidth = CommonButtonWidth;
        characterLabel.myHeight = CommonButtonHeight;
        characterLabel.text = charcterStr;
        characterLabel.tag = 600 + i;
        [thirdRowLayout addSubview:characterLabel];
    }
    [self addSubview:thirdRowLayout];
    
}
#pragma mark - fourthRowLayout 第四排数字
- (void)addFourthRowLayout {
    MyLinearLayout *fourthRowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    fourthRowLayout.myLeading = 0;
    fourthRowLayout.myTop = 0;
    fourthRowLayout.myWidth = self.bounds.size.width;
    fourthRowLayout.myHeight = kSubLayoutHeighth;
    // 第四排按钮
    for (int i = 9; i <= 11; i ++) {
        
        if (i == 9) {
            UIButton *subButton = [[UIButton alloc] init];
            subButton.myLeading = kButtonBetweenGap;
            subButton.myTop = kButtonBetweenGap / 2.f;
            subButton.myWidth = CommonButtonWidth;
            subButton.myHeight = CommonButtonHeight;
            [self setUpToCharacterButton:subButton];
            _leftBottomButton = subButton;
            [self nonActiveButtonX];
            [fourthRowLayout addSubview:subButton];
            
        }else if (i == 10) {
            NSString *charcterStr = self.numberArray[9];
            MCCharacterLabel *characterLabel = [[MCCharacterLabel alloc] init];
            characterLabel.isHidBigLabel = YES;
            characterLabel.myLeading = kButtonBetweenGap;
            characterLabel.myTop = kButtonToSuperGap;
            characterLabel.myWidth = CommonButtonWidth;
            characterLabel.myHeight = CommonButtonHeight;
            characterLabel.text = charcterStr;
            characterLabel.tag = 600 + i;
            [fourthRowLayout addSubview:characterLabel];
            
        }else if(i == 11) {
            UIButton *subButton = [[UIButton alloc] init];
            subButton.myLeading = kButtonBetweenGap;
            subButton.myTop = kButtonBetweenGap / 2.f;
            subButton.myWidth = CommonButtonWidth;
            subButton.myHeight = CommonButtonHeight;
            [self setUpDeleteButton:subButton];
            [fourthRowLayout addSubview:subButton];
        };
    }
    [self addSubview:fourthRowLayout];
}


#pragma mark -  切换字母键盘按钮设置
- (void)setUpToCharacterButton:(UIButton *)subButton{
    NSString *titleString;
    if (NumberKeyboardStyleDelete == self.keyboardStyle) {
        titleString = @"全部删除";
    }else if (NumberKeyboardStylePoint == self.keyboardStyle) {
        titleString = @".";
        
    }else if (NumberKeyboardStyleX == self.keyboardStyle) {
        titleString = @"X";
    }else {
        titleString = @"";
        subButton.enabled = NO;
    };
    [subButton setTitle:titleString forState:UIControlStateNormal];
    subButton.titleLabel.font = [UIFont systemFontOfSize:kSecutiryKeyboardTitleFont];
    [subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [subButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self setLayerFeatures:subButton];
    subButton.layer.backgroundColor = kButtonNormalColor.CGColor;
    [subButton setBackgroundImage:[UIImage imageNamed:@"NumberKeyBoard_Number_TouchDown"] forState:UIControlStateHighlighted];
    [subButton addTarget:self action:@selector(clickLeftBottomButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -  删除按钮设置
- (void)setUpDeleteButton:(UIButton *)subButton{
    [subButton setImage: [UIImage imageNamed:@"NumberKeyBoard_Back_Normal"] forState:UIControlStateNormal];
    [subButton setImage:[UIImage imageNamed:@"NumberKeyBoard_Back_TouchDown"] forState:UIControlStateHighlighted];
    [subButton addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 设置圆角以及边框特性
- (void)setLayerFeatures:(UIView *)view {
    view.layer.cornerRadius = 5.f;
    view.layer.borderWidth = 0.5f;
    view.layer.borderColor = [UIColor colorWithRed:94/255.0 green:98/255.0 blue:99/255.0 alpha:1.0].CGColor;
}

#pragma mark - 获取0~9打乱顺序的数组
- (NSMutableArray *)getRandomArray {
    [_numberArray removeAllObjects];
    NSMutableArray *arrM = [NSMutableArray array];
    [arrM removeAllObjects];
    for (int i = 0 ; i < 10; i++) {
        
        int j = arc4random_uniform(10);
        NSNumber *number = [[NSNumber alloc] initWithInt:j];
         NSString *numberStr = [number stringValue];
        if ([arrM containsObject:numberStr]) {
            i--;
            continue;
        }
        [arrM addObject:numberStr];
    }
    return arrM;
}

#pragma mark - 获取0~9顺序的数组
- (NSMutableArray *)getOrderArray {
    [_numberArray removeAllObjects];
    NSMutableArray *arrM = [NSMutableArray array];
    [arrM removeAllObjects];
    arrM = [NSMutableArray arrayWithObjects:@"1",@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    return arrM;
}

#pragma mark - 触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //    NSLog(@"开始");
    CGPoint point = [[touches anyObject] locationInView:self];
    for (MyLinearLayout *linerLayout in self.subviews) {
        
        for (MCCharacterLabel *characterLabel in linerLayout.subviews) {
            
            CGRect rect = [linerLayout convertRect:characterLabel.frame toView:self];
            if ( characterLabel.tag >= 600) {
                if (_isNotActive) {
                    [characterLabel notActiveState];
                    
                }else if (CGRectContainsPoint(rect, point)) {
                    [characterLabel selectedState];
                    
                }else {
                    [characterLabel notSeletedState];
                };
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
            if ( characterLabel.tag >= 600) {
                if (_isNotActive) {
                    [characterLabel notActiveState];
                    
                }else if (CGRectContainsPoint(rect, point)) {
                    [characterLabel selectedState];
                    
                }else {
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
            if ( characterLabel.tag >= 600) {
                if (_isNotActive) {
                    [characterLabel notActiveState];
                    
                }else if(CGRectContainsPoint(rect, point)) {
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
            if ( characterLabel.tag >= 600) {
                if (CGRectContainsPoint(rect, point)) {
                    //                    NSLog(@"%@",characterLabel.text);
                    [characterLabel notSeletedState];
                    
                } 
            }
        }
    }
}

#pragma mark - 字母点击
- (void)clickCharacterBlock:(NSString *)characterStr {
    [SoundAndShakeTool play];
    if (self.clickNumberBlock) {
        self.clickNumberBlock(characterStr);
    }
}

- (void)getClickNumberBlock:(NumberKeyboardClickInputBlock)clickNumberBlock {
    _clickNumberBlock = clickNumberBlock;
}

#pragma mark -  左下按钮点击
- (void)clickLeftBottomButton:(UIButton *)leftBottomButton {
     [SoundAndShakeTool play];
    if (NumberKeyboardStyleDelete == self.keyboardStyle) {
        if (self.clickTotalDeleteBlock) {
            self.clickTotalDeleteBlock();
        };
        
    }else if (NumberKeyboardStylePoint == self.keyboardStyle) {
        if (self.clickDotBlock) {
            self.clickDotBlock(@".");
        };
        
    }else if (NumberKeyboardStyleX == self.keyboardStyle) {
        if (self.clickXBlock) {
            self.clickXBlock(@"X");
        };
        
    }else {
        
    };
}
- (void)getClickDotBlock:(NumberKeyboardClickInputBlock)clickDotBlock {
    _clickDotBlock = clickDotBlock;
}
- (void)getClickXBlock:(NumberKeyboardClickInputBlock)clickXBlock {
    _clickXBlock = clickXBlock;
}
- (void)getClickTotalDeleteBlock:(NumberKeyboardClickNonInputBlock)clickTotalDeleteBlock {
    _clickTotalDeleteBlock = clickTotalDeleteBlock;
}
#pragma mark -  删除按钮点击
- (void)clickDeleteButton:(UIButton *)deleteButton {
    [SoundAndShakeTool play];
    if (self.clickDeleteBlock) {
        self.clickDeleteBlock();
    }
}

- (void)getClickDeleteBlock:(NumberKeyboardClickNonInputBlock)clickDeleteBlock {
    _clickDeleteBlock = clickDeleteBlock;
}
#pragma mark -  激活按钮X
- (void)activeButtonX {
    
    if ([_leftBottomButton.titleLabel.text isEqualToString:@"X"] || [_leftBottomButton.titleLabel.text isEqualToString:@"."]) {
            [_leftBottomButton setEnabled:YES];
            _leftBottomButton.layer.backgroundColor = kButtonNormalColor.CGColor;
    };
    
}
#pragma mark -  置灰按钮X
- (void)nonActiveButtonX {
        if ([_leftBottomButton.titleLabel.text isEqualToString:@"X"] || [_leftBottomButton.titleLabel.text isEqualToString:@"."]) {
            [_leftBottomButton setEnabled:NO];
            _leftBottomButton.layer.backgroundColor = kBackgroundColor.CGColor;
        };
}
#pragma mark - 激活数字按钮
- (void)activeNumberButton {
    _isNotActive = NO;
    for (MyLinearLayout *linerLayout in self.subviews) {
        for (MCCharacterLabel *characterLabel in linerLayout.subviews) {
            if ( characterLabel.tag >= 600) {
               [characterLabel notSeletedState];
            }
        }
    }
}

#pragma mark - 未激活数字按钮
- (void)nonActiveNumberButton {
    _isNotActive = YES;
    for (MyLinearLayout *linerLayout in self.subviews) {
        for (MCCharacterLabel *characterLabel in linerLayout.subviews) {
            if ( characterLabel.tag >= 600) {
                [characterLabel notActiveState];
            }
        }
    }
}
@end
