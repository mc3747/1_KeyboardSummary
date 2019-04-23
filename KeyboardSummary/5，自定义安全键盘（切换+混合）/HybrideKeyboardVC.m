//
//  HybrideKeyboardVC.m
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "HybrideKeyboardVC.h"
#import "SafeKeyBoardField.h"
#import "HybrideKeyBoardField.h"

@interface HybrideKeyboardVC ()

@property (weak, nonatomic) IBOutlet SafeKeyBoardField *textField1;
@property (weak, nonatomic) IBOutlet HybrideKeyBoardField *textField2;

@end

@implementation HybrideKeyboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_textField1 setSafeKeyBoardType:SafeKeyBoardTypeNumber];
    [_textField2 setHybrideKeyBoardType:HybrideKeyBoardTypeCharacter];
}





@end
