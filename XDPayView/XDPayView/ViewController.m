//
//  ViewController.m
//  XDPayView
//
//  Created by miaoxiaodong on 16/7/23.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import "ViewController.h"
#import "XDMoneyInputView.h"
#import "XDPayPasswordView.h"

@interface ViewController ()<XDPayPasswordViewDelegate>
{
    XDMoneyInputView *_moneyTextField;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _moneyTextField = [[XDMoneyInputView alloc] initWithFrame:CGRectMake(30, 50, self.view.frame.size.width - 60, 50)];
    [self.view addSubview:_moneyTextField];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(30, 140, self.view.frame.size.width - 60, 50)];
    [btn setTitle:@"支付" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:25];
    btn.layer.borderColor = [UIColor blueColor].CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick
{
    XDPayPasswordView *payPasswordView = [[XDPayPasswordView alloc] init];
    payPasswordView.delegate = self;
    payPasswordView.money = [NSString stringWithFormat:@"%.2f", _moneyTextField.moneyTextField.text.floatValue];
    [self.view.window addSubview:payPasswordView];
}
- (void)passwordInputOver:(NSString *)password payPasswordView:(XDPayPasswordView *)payPasswordView
{
    NSLog(@"密码 = %@", password);
    [payPasswordView removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
