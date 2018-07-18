//
//  MCNumberKeyboardTextView.m
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/9.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "MCPasswordKeyboardTextView.h"
#import "MCNumberKeyboardView.h"
#import "UIView+Extension.h"

const static NSInteger kNum = 6;

@interface MCPasswordKeyboardTextView()
@property (nonatomic, strong) MCNumberKeyboardView         *keyBoardView;
@property (nonatomic, assign) CGFloat                       gridWidth;  //每个格子的宽
@property (nonatomic, weak) UIView                          *curView;
@property (nonatomic, copy) NSString                        *contentText;
@property (nonatomic, assign) BOOL isClick;
@end


@implementation MCPasswordKeyboardTextView
#pragma mark -  初始化
- (instancetype)initWithFrame:(CGRect)frame inView:(UIView *)curView {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self baseConfigWithView:curView];
    }
    return self;
}
#pragma mark -  curView设置
- (void)setCurrentView:(UIView *)curView {
    
    [self baseConfigWithView:curView];
}
#pragma mark -  基础配置
- (void)baseConfigWithView:(UIView *)curView  {
    
    if (!curView || ![curView isKindOfClass:[UIView class]]) {
        return;
    };
    
    // 依附的view
    _curView = curView;
    // 键盘的配置
    [self configBlackCircleKeyboard :curView];
    // 系统键盘的监听
    [self keyboardEvent];
}

#pragma mark -  默认黑圈交易密码设置
- (void)configBlackCircleKeyboard :(UIView *)curView{
    _curView = curView;
    // 基础view
    UIView *baseView = [self configBaseView];
    __weak typeof(self) weakSelf = self;
    // 弹出键盘
    [baseView GJSHandleClick:^(UIView *view) {
        [weakSelf.keyBoardView showInView:curView];
        if (weakSelf.returnBlock) {
            weakSelf.returnBlock(weakSelf,weakSelf.contentText,YES);
        };
    }];
    // 置空内容
    self.contentText = @"";
    // 基础view的点击回调
    self.keyBoardView = [self getDefaultKeyBoardView];
    self.keyBoardView.returnBlock = ^(NSString *textString, ReturnBlockType type) {
        //删除一位
        if (ReturnBlockTypeClearOne == type) {
            if (weakSelf.contentText.length > 0) {
                weakSelf.contentText = [weakSelf.contentText substringToIndex:weakSelf.contentText.length - 1];
            }
            [weakSelf initTextInputFlag:weakSelf.contentText];
            
            //全部删除
        }else if (ReturnBlockTypeClearAll == type) {
            weakSelf.contentText = @"";
            [weakSelf initTextInputFlag:weakSelf.contentText];
            
            //数字按钮
        }else if (weakSelf.contentText.length < kNum && type == ReturnBlockTypeDefuatl) {
            weakSelf.contentText = [weakSelf.contentText stringByAppendingString:textString];
            if (weakSelf.contentText.length <= 6) {
                [weakSelf initTextInputFlag:weakSelf.contentText];
            }
        }
    };
}
#pragma mark - 基础view
- (UIView *)configBaseView{
    //背景view
    UIView *baseView = [[UIView alloc] initWithFrame:self.bounds];
    baseView.layer.borderWidth = 1.f;
    baseView.layer.borderColor = COMMON_LIGHT_GREY_COLOR.CGColor;
    baseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:baseView];
    //竖线
    self.gridWidth = self.width/kNum;
    for (NSInteger i = 0; i < kNum - 1; i++) { //只需5条线
        CGFloat lineX = self.gridWidth*(i+1);
        UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(lineX - 1, 3, 1.f, self.height - 6)];
        sepLine.backgroundColor = COMMON_LIGHT_GREY_COLOR;
        [baseView addSubview:sepLine];
    }
    //黑圆圈
    for (NSInteger i = 0; i < kNum; i++) {
        CGFloat lineX = self.gridWidth*i + (self.gridWidth - 20)/2;
        CGFloat lineY = (self.height - 20)/2;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, 20, 20)];
        view.tag = 10000+i;
        view.backgroundColor = COMMON_BLACK_COLOR;
        view.layer.cornerRadius = 10;
        view.hidden = YES;
        [baseView addSubview:view];
    }
    return baseView;
}
#pragma mark - 键盘点击后，显示黑色圆圈
- (void)initTextInputFlag:(NSString *)text {
    
    NSInteger maxTag = 10005;
    NSInteger length = text.length;
    NSInteger curMaxTag = 10000+length;
    for (NSInteger i = 0; i < length; i++) {
        UIView *view = [self viewWithTag:10000+i];
        view.hidden = NO;
    }
    for (NSInteger i = 0; i <= maxTag - curMaxTag; i++) {
        UIView *view = [self viewWithTag:10005 - i];
        view.hidden = YES;
    }
    
    if (_returnBlock) {
        _returnBlock(self,text,NO);
    };
    
}

- (void)keyboardEvent
{
    //监听键盘出现和消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark textField键盘出现
- (void)keyboardWillShow:(NSNotification *)note
{
    
    [self keyBoardResignFirstResponder];
}

#pragma mark - 退出键盘
- (void)keyBoardResignFirstResponder {
    [self.keyBoardView downInView];
}

#pragma mark - 弹出键盘
- (void)keyBoardBecomeFirstResponder {
    [self.keyBoardView showInView:_curView];
}

#pragma mark -  方法监听
- (void)shouldChangeNumbers:(MCNumberPasswordKeyboardBlock )returnBlock {
    _returnBlock = returnBlock;
}

#pragma mark - 默认键盘view
- (MCNumberKeyboardView *)getDefaultKeyBoardView {
    
    if (!_keyBoardView) {
        _keyBoardView = [[MCNumberKeyboardView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT, MAIN_SCREEN_WIDTH, 216 + 39 + IPHONE_X_Bottom_SafeArea_Height)];
        [_curView addSubview:_keyBoardView];
    }
    return _keyBoardView;
}
@end
