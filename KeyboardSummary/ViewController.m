//
//  ViewController.m
//  KeyboardSummary
//
//  Created by gjfax on 2018/7/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ViewController.h"
#import "GoodKeyboardVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"键盘汇总";
    self.view.backgroundColor = [UIColor blueColor];
}

- (IBAction)GoodKeyboradAction:(id)sender {
    GoodKeyboardVC *vc= [[GoodKeyboardVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
