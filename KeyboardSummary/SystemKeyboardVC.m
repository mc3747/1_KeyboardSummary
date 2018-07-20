//
//  SystemKeyboardVC.m
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "SystemKeyboardVC.h"

@interface SystemKeyboardVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *numberPadTF;
@property (weak, nonatomic) IBOutlet UITextField *phonePadTF;

@end

@implementation SystemKeyboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统键盘";
    self.view.backgroundColor = [UIColor yellowColor];
    _numberPadTF.delegate = self;
    _phonePadTF.delegate = self;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSArray *ws = [[UIApplication sharedApplication] windows];
    for(UIView *w in ws){
        NSArray *vs = [w subviews];
        for(UIView *v in vs){
//            if([[NSString stringWithUTF8String:object_getClassName(v)] isEqualToString:@"UIKeyboard"]){
//                v.backgroundColor = [UIColor redColor];
//            }
            if([[NSString stringWithUTF8String:object_getClassName(v)] isEqualToString:@"UIPeripheralHostView"]){
                v.backgroundColor = [UIColor redColor];
                }
        }
    }
    
}

@end
