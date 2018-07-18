//
//  SecurityNumberKeyBoardView.m
//  HX_GJS
//
//  Created by gjfax on 16/2/1.
//  Copyright © 2016年 GjFax. All rights reserved.
//

#import "MCPasswordKeyboardView.h"
#import "SoundAndShakeTool.h"
#import "UIView+Extension.h"

/** 键盘顶部高度 */
#define kTopheight 39.f
/** 键盘主体高度 */
#define Kheight 216.f
/** 键盘行边距&&列边距 */
#define kButtonToSuperGap  3.f
/** 键盘按钮行间距&&列间距 */
#define kButtonBetweenGap  4.f

@interface MCPasswordKeyboardView ()

@property (nonatomic, strong) NSMutableArray       *randomArray;
@property (nonatomic, weak) UIView                 *keyBoardView;
@end

@implementation MCPasswordKeyboardView

#pragma mark - 默认初始化方法：默认数字乱序 + 清除
- (instancetype)init {
    
    self = [super initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT, MAIN_SCREEN_WIDTH, Kheight + kTopheight + IPHONE_X_Bottom_SafeArea_Height)];
    if (self) {

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(closeInView)
                                                     name:GJS_KeyBoard_DownView_Noti
                                                   object:nil];
        self.numberKeyboardStyle = NumberKeyboardStyleDisorder;
        [self initTopView];
        [self initBaseViewWithStyle:NumberKeyboardStyleDisorder];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(closeInView)
                                                     name:GJS_KeyBoard_DownView_Noti
                                                   object:nil];
        self.numberKeyboardStyle = NumberKeyboardStyleDisorder;
        [self initTopView];
        [self initBaseViewWithStyle:NumberKeyboardStyleDisorder];
        
    }
    return self;
}

#pragma mark - 自定义初始化方法
- (instancetype)initWithFrame:(CGRect)frame andStyle:(NumberKeyboardStyle)numberKeyboardStyle{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(closeInView)
                                                     name:GJS_KeyBoard_DownView_Noti
                                                   object:nil];
        self.numberKeyboardStyle = numberKeyboardStyle;
        [self initTopView];
        [self initBaseViewWithStyle:numberKeyboardStyle];
        
    }
    return self;
}

#pragma mark - 键盘顶部view
- (void)initTopView {
    
    UIView *topView = [self viewWithTag:12345];
    if (!topView) {
        topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, kTopheight)];
        topView.tag = 12345;
        topView.backgroundColor = [UIColor whiteColor];
        //顶部细线
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [ COMMON_LIGHT_GREY_COLOR CGColor];
        self.layer.backgroundColor = [[UIColor whiteColor] CGColor];
        //logo
        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(5, (kTopheight - 25) * 0.5f, 25, 25)];
        logoView.image = [UIImage imageNamed:@"Custom_KeyBoard_Logo_Icon"];
        [topView addSubview:logoView];
        //文字
        UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 200, kTopheight)];
        tipsLabel.text = @"正在使用***安全键盘";
        tipsLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0  blue:60/255.0  alpha:1.0];
        tipsLabel.font = [UIFont systemFontOfSize:15.f];
        [topView addSubview:tipsLabel];
        //收起箭头
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(topView.width - 30 - 30, (topView.height - 30) * 0.5f, 30, 30);
        [doneBtn setImage:[UIImage imageNamed:@"Custom_KeyBoard_Down_Icon"] forState:UIControlStateNormal];
        [doneBtn setImage:[UIImage imageNamed:@"AccessoryView_Finish_TouchDown"] forState:UIControlStateHighlighted];
        [topView addSubview:doneBtn];
        __weak typeof(self) weakSelf = self;
        [doneBtn GJSHandleClick:^(UIView *view) {
            [weakSelf downInView];
        }];
    }
    [self addSubview:topView];

}

#pragma mark - 键盘view
- (void)initBaseViewWithStyle:(NumberKeyboardStyle)numberKeyboardStyle {
    [self.randomArray removeAllObjects];
    if (NumberKeyboardStyleDisorder ==  numberKeyboardStyle) {
         self.randomArray = [self getRandomArray];
    } else {
        self.randomArray = [self getOrderArray];
    };
   
    UIView *keyBoardView = [self viewWithTag:20001];
    
    if (!keyBoardView) {
        keyBoardView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopheight, MAIN_SCREEN_WIDTH, Kheight)];
        keyBoardView.tag = 20001;
        keyBoardView.backgroundColor = [UIColor colorWithRed:208/256.f green:216/256.f blue:226/256.f alpha:1.f];
        [self addSubview:keyBoardView];
    }
    
    //初始化12个btn按钮
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            UIButton *button = [self creatButtonWithX:i Y:j];
            [keyBoardView addSubview:button];
        }
    };
    
    _keyBoardView = keyBoardView;
}

#pragma mark - 创建每个按键button
-(UIButton *)creatButtonWithX:(NSInteger)x Y:(NSInteger)y
{
    NSInteger num = y + 3*x + 1;

    UIButton *button = [self viewWithTag:num];
    
    if (!button) {
        CGFloat heighth = (Kheight - 2 * kButtonToSuperGap - 3 * kButtonBetweenGap ) / 4;
        CGFloat width = (MAIN_SCREEN_WIDTH - 2 * kButtonToSuperGap - 2 * kButtonBetweenGap) / 3;
        CGFloat frameY = (heighth + kButtonBetweenGap) * x + kButtonToSuperGap ;
        CGFloat frameX = (width + kButtonBetweenGap) * y + kButtonToSuperGap ;
        button = [[UIButton alloc] initWithFrame:CGRectMake(frameX, frameY, width, heighth)];
        button.tag = num;
        button.layer.cornerRadius = 5.f;
        button.layer.borderWidth = 0.5f;
        button.layer.borderColor = [UIColor colorWithRed:94/255.0 green:98/255.0 blue:99/255.0 alpha:1.0].CGColor;
        button.layer.backgroundColor = [UIColor whiteColor].CGColor;

        [button setBackgroundImage:[UIImage imageNamed:@"NumberKeyBoard_Number_TouchDown"] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSString *title = @"";

    if (num < 10) {
        title = [NSString stringWithFormat:@"%@",self.randomArray[num - 1]];
        
    }else if (num == 10) {
        if (NumberKeyboardStyleOrderDelete == self.numberKeyboardStyle || NumberKeyboardStyleDisorder == self.numberKeyboardStyle) {
            title = @"删除全部";
        }else if (NumberKeyboardStyleOrderPoint == self.numberKeyboardStyle) {
            title = @".";
        }else if (NumberKeyboardStyleOrderX == self.numberKeyboardStyle) {
            title = @"X";
        };
        
    }else if (num == 11) {
        title = [NSString stringWithFormat:@"%@",[self.randomArray lastObject]];
        
    }else if (num == 12) {
        [button setImage:[UIImage imageNamed:@"Custom_KeyBoard_Clear_Icon"] forState:UIControlStateNormal];
    }
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (num == 10 || num == 12) {
        button.backgroundColor = [UIColor colorWithRed:208/256.f green:216/256.f blue:226/256.f alpha:1.f];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    return button;
}

#pragma mark - 按钮点击
-(void)clickButton:(UIButton *)sender
{
    [SoundAndShakeTool play];
    if (self.returnBlock) {
        if (sender.tag == 10 && (NumberKeyboardStyleOrderDelete == self.numberKeyboardStyle)) {
            self.returnBlock(@"", ReturnBlockTypeClearAll);
            
        }else if (sender.tag == 10 && (NumberKeyboardStyleDisorder == self.numberKeyboardStyle)) {
            self.returnBlock(@"", ReturnBlockTypeClearAll);
            
        }else if (sender.tag == 12) {
            self.returnBlock(@"", ReturnBlockTypeClearOne);
            
        }else {
            self.returnBlock(sender.titleLabel.text, ReturnBlockTypeDefuatl);
        };
    }
    
}

#pragma mark - 弹出键盘
- (void)showInView:(UIView *)view {
    
    if (self.y == MAIN_SCREEN_HEIGHT) {
        [self initTopView];
        [self initBaseViewWithStyle:self.numberKeyboardStyle];
        GJWeakSelf;
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.frame = CGRectMake(0, MAIN_SCREEN_HEIGHT - Kheight - kTopheight - IPHONE_X_Bottom_SafeArea_Height, MAIN_SCREEN_WIDTH, Kheight + kTopheight + IPHONE_X_Bottom_SafeArea_Height);
        }];
        [view bringSubviewToFront:self];
    }

}

#pragma mark - 隐藏键盘
- (void)downInView {
    if (self.finishBlock) {
        self.finishBlock();
    };
    GJWeakSelf;
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.frame = CGRectMake(0, MAIN_SCREEN_HEIGHT, MAIN_SCREEN_WIDTH, Kheight + kTopheight + IPHONE_X_Bottom_SafeArea_Height);
    }];
}

#pragma mark - 关闭view
- (void)closeInView {
    
    [self removeAllSubviews];
    [self removeFromSuperview];
}

#pragma mark -键盘数组随机
- (NSMutableArray *)getRandomArray
{
    //随机数从这里边产生
    NSMutableArray *startArray = [[NSMutableArray alloc] initWithObjects:@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, nil];
    //随机数产生结果
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    //随机数个数
    NSInteger number = startArray.count;
    for (int i = 0; i < number; i++) {
        int t = arc4random () % startArray.count;
        resultArray[i] = startArray[t];
        startArray[t] = [startArray lastObject]; //为更好的乱序，故交换下位置
        [startArray removeLastObject];
    }
    return resultArray;
}

#pragma mark - 获取0~9顺序的数组
- (NSMutableArray *)getOrderArray {
    NSMutableArray *arrM = [NSMutableArray array];
    [arrM removeAllObjects];
    arrM = [NSMutableArray arrayWithObjects:@"1",@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    return arrM;
}
#pragma mark -  激活按钮X
- (void)activeButtonX {
    for (UIButton *btn in self.keyBoardView.subviews) {
        if (btn.tag == 10 && ([btn.titleLabel.text isEqualToString:@"X"] || [btn.titleLabel.text isEqualToString:@"."])) {
            [btn setEnabled:YES];
            [btn setBackgroundImage:[self imageWithColor: [UIColor whiteColor]] forState:UIControlStateNormal];
        }
    }
}
#pragma mark -  置灰按钮X
- (void)nonActiveButtonX {
    for (UIButton *btn in self.keyBoardView.subviews) {
        if (btn.tag == 10 && ([btn.titleLabel.text isEqualToString:@"X"] || [btn.titleLabel.text isEqualToString:@"."])) {
            [btn setEnabled:NO];
            [btn setBackgroundImage:[self imageWithColor:COMMON_GREY_COLOR] forState:UIControlStateNormal];
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
