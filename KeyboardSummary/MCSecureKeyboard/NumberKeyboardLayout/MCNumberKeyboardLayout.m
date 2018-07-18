//
//  MCNumberKeyboardLayout.m
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/25.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "MCNumberKeyboardLayout.h"
#import "SoundAndShakeTool.h"
/** 键盘行边距&&列边距 */
static CGFloat const kButtonToSuperGap = 3.f;
/** 键盘按钮行间距&&列间距 */
static CGFloat const kButtonBetweenGap = 4.f;
/** 键盘主体高度 */
static CGFloat const kMainKeyboardHeight = 216;

/** 背景通用颜色 */
#define CommonBackgroundColor [UIColor colorWithRed:208/256.f green:216/256.f blue:226/256.f alpha:1.f]
/** 数字按钮宽度 */
#define CommonButtonWidth ([UIScreen mainScreen].bounds.size.width - 2 *(kButtonToSuperGap + kButtonBetweenGap)) / 3.f
/** 数字按钮高度 */
#define CommonButtonHeight (kMainKeyboardHeight - 3*kButtonToSuperGap - 2*kButtonBetweenGap)/4.f


@interface MCNumberKeyboardLayout ()
@property(nonatomic,strong)NSMutableArray *numberArray;
@end
@implementation MCNumberKeyboardLayout
- (void)dealloc {
    DLog(@"数字键盘消失");
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = CommonBackgroundColor;
        self.orientation = MyOrientation_Vert;
        if (_isNumberKeyboardOrder) {
            self.numberArray = [self getOrderArray];
        } else {
            self.numberArray = [self getRandomArray];
        }
        [self addSubLayouts];
        [self handleSubLayouts];
    }
    return self;
}

#pragma mark - 数字键盘设置乱序属性后的setter方法
- (void)setIsNumberKeyboardOrder:(BOOL)isNumberKeyboardOrder
{
    if (isNumberKeyboardOrder) {
        self.numberArray = [self getOrderArray];
        [self removeAllSubviews];
        [self addSubLayouts];
        [self handleSubLayouts];
    }
}

#pragma mark - 添加子控件
- (void)addSubLayouts {
    
    for (int i = 0; i<= 3; i++) {
        MyLinearLayout *rowLayout = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        rowLayout.myLeading = 0;
        rowLayout.myTop = 0;
        rowLayout.myWidth = self.bounds.size.width;
        rowLayout.myHeight = kMainKeyboardHeight * 0.25f;
        for (int j = 0; j <=2; j++) {
            UIButton *numberButton = [[UIButton alloc] init];
            numberButton.myLeading = kButtonToSuperGap;
            if (j > 0) {
            numberButton.myLeading = kButtonBetweenGap;
            }
            numberButton.myTop = kButtonToSuperGap;
            if (i > 0) {
            numberButton.myTop = kButtonBetweenGap / 2.f;
            }
            numberButton.myWidth = CommonButtonWidth;
            numberButton.myHeight = CommonButtonHeight;
            [rowLayout addSubview:numberButton];
        }
        [self addSubview:rowLayout];
    }
}

#pragma mark - 布局子控件
- (void)handleSubLayouts {
    NSUInteger count = self.subviews.count;

    for (NSUInteger i = 0; i < count; i++) {
        MyLinearLayout *rowLayout = self.subviews[i];
        NSUInteger subCount = rowLayout.subviews.count;
    // 头三排的子控件
        if (i < count - 1) {
            for(int j = 0;j < subCount; j++) {
                UIButton *subButton = rowLayout.subviews[j];
                [subButton setTitle:_numberArray[i*3 + j ] forState:UIControlStateNormal];
                [self setUpNumberButton:subButton];
            }
    // 第四排的子控件
        } else if(i == count - 1) {
            for(int j = 0;j < subCount; j++) {
                UIButton *subButton = rowLayout.subviews[j];
                
                if (j == 0 ) {
                    [self setUpToCharacterButton:subButton];
                    
                } else if (j == subCount - 1){
                    [self setUpDeleteButton:subButton];
                    
                } else {
                    [subButton setTitle:_numberArray[9] forState:UIControlStateNormal];
                    [self setUpNumberButton:subButton];
                }
            }
        }
    
    }
}
#pragma mark -  切换字母键盘按钮设置
- (void)setUpToCharacterButton:(UIButton *)subButton{
    [subButton setTitle:@"ABC" forState:UIControlStateNormal];
    subButton.titleLabel.font = [UIFont systemFontOfSize:kSecutiryKeyboardTitleFont];
    [subButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setLayerFeatures:subButton];
    subButton.layer.backgroundColor = CommonBackgroundColor.CGColor;
    [subButton setBackgroundImage:[UIImage imageNamed:@"NumberKeyBoard_Number_TouchDown"] forState:UIControlStateHighlighted];
    [subButton addTarget:self action:@selector(clickToCharacterButton:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -  切换字母键盘按钮点击
- (void)clickToCharacterButton:(UIButton *)toCharacterButton {
    [SoundAndShakeTool play];
    if (self.numberKeyboardClikToCharacterBlock) {
        self.numberKeyboardClikToCharacterBlock();
    }
}

- (void)getClikToCharacterBlock:(NumberKeyboardClikBlock)numberKeyboardClikToCharacterBlock {
    _numberKeyboardClikToCharacterBlock = numberKeyboardClikToCharacterBlock;
}
#pragma mark -  删除按钮设置
- (void)setUpDeleteButton:(UIButton *)subButton{
    [subButton setImage: [UIImage imageNamed:@"NumberKeyBoard_Back_Normal"] forState:UIControlStateNormal];
    [subButton setImage:[UIImage imageNamed:@"NumberKeyBoard_Back_TouchDown"] forState:UIControlStateHighlighted];
    [subButton addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -  删除按钮点击
- (void)clickDeleteButton:(UIButton *)deleteButton {
    [SoundAndShakeTool play];
    if (self.numberKeyboardClikDeleteBlock) {
        self.numberKeyboardClikDeleteBlock();
    }
}

- (void)getClikDeleteBlock:(NumberKeyboardClikBlock)numberKeyboardClikDeleteBlock {
    _numberKeyboardClikDeleteBlock = numberKeyboardClikDeleteBlock;
}
#pragma mark - 数字按钮设置
- (void)setUpNumberButton:(UIButton *)subButton{
    [self setLayerFeatures:subButton];
    subButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [subButton setBackgroundImage:[UIImage imageNamed:@"NumberKeyBoard_Number_TouchDown"] forState:UIControlStateHighlighted];
    subButton.titleLabel.font = [UIFont systemFontOfSize:kSecutiryKeyboardTitleFont];
    [subButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [subButton addTarget:self action:@selector(clickNumberButton:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 设置圆角以及边框特性
- (void)setLayerFeatures:(UIView *)view {
    view.layer.cornerRadius = 5.f;
    view.layer.borderWidth = 0.5f;
    view.layer.borderColor = [UIColor colorWithRed:94/255.0 green:98/255.0 blue:99/255.0 alpha:1.0].CGColor;
}
#pragma mark - 数字按钮点击
- (void)clickNumberButton:(UIButton *)numberButton {
    [SoundAndShakeTool play];
    if (self.numberKeyboardClikNumberBlock) {
        self.numberKeyboardClikNumberBlock(numberButton.titleLabel.text);
    }
}
- (void)getClikNumberBlock:(NumberKeyboardClikNumberBlock)numberKeyboardClikNumberBlock {
    _numberKeyboardClikNumberBlock = numberKeyboardClikNumberBlock;
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

@end
