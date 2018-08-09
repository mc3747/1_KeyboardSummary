//
//  MCCharacterLabel.m
//  自定义安全键盘（纯代码）
//
//  Created by gjfax on 2017/5/18.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "MCCharacterLabel.h"

@interface MCCharacterLabel ()

/*放大图片*/
@property (nonatomic, strong) UILabel *enLargeLabel;

@end


@implementation MCCharacterLabel
#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        [self setLayerFeatures:self];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:kSecutiryKeyboardTitleFont];
        self.userInteractionEnabled = YES;
        [self isExclusiveTouch];
    } ;
    return self;
}
#pragma mark - 选中状态
- (void)selectedState {
    self.layer.backgroundColor = RGBColor(51, 167, 196).CGColor;
    if (!_isHidBigLabel) {
        self.enLargeLabel.hidden = NO;
    };
    self.textColor = [UIColor whiteColor];
}
#pragma mark - 未选中状态
- (void)notSeletedState {
    self.layer.backgroundColor = RGBColor(57, 57, 57).CGColor;
    if (!_isHidBigLabel) {
        self.enLargeLabel.hidden = YES;
    };
    self.textColor = [UIColor whiteColor];
}

- (void)changeLabelString:(NSString *)labelString {
    self.text = labelString;
    if (!_isHidBigLabel) {
        self.enLargeLabel.text = labelString;
    };
}
#pragma mark - 设置圆角以及边框特性
- (void)setLayerFeatures:(UIView *)view {
    view.layer.cornerRadius = 5.f;
    view.layer.backgroundColor = RGBColor(57, 57, 57).CGColor;
    view.layer.borderWidth = 0.5f;
    view.layer.borderColor = [UIColor colorWithRed:94/255.0 green:98/255.0 blue:99/255.0 alpha:1.0].CGColor;
}
#pragma mark - 放大图片
- (UILabel *)enLargeLabel
{
    if (!_enLargeLabel) {
        CGSize size = [UIImage imageNamed:@"Custom_CharacterKeyBoard_PopOut_Icon@2x"].size;
        CGFloat enlargeLabelX = self.bounds.origin.x - (size.width - self.bounds.size.width) * 0.5f;
        //最左侧图片
        if (_isLeftLabel) {
           enlargeLabelX = 0;
        }
        //最右侧图片
        if (_isRightLabel) {
            enlargeLabelX = self.bounds.origin.x - (size.width - self.bounds.size.width) ;
        }
        _enLargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(enlargeLabelX, self.bounds.origin.y - size.height - 5, size.width, size.height)];
        _enLargeLabel.textAlignment = NSTextAlignmentCenter;
        [self setLayerFeatures:_enLargeLabel];
        self.enLargeLabel.layer.shadowColor =RGBColor(51, 167, 196).CGColor;
        self.enLargeLabel.layer.shadowRadius = 10.f;
        self.enLargeLabel.layer.shadowOffset = CGSizeMake(0, 0);
        self.enLargeLabel.layer.shadowOpacity = 0.8f;
        self.enLargeLabel.text = self.text;
        self.enLargeLabel.textColor = [UIColor whiteColor];
        self.enLargeLabel.font = [UIFont systemFontOfSize:kCommonSecutiryKeyboardLargeLabelFont];
        _enLargeLabel.hidden = YES;
        [self addSubview:_enLargeLabel];
    }
    return _enLargeLabel;
}

@end
