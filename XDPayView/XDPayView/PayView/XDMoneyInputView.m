//
//  XDMoneyInputView.m
//  XDPayView
//
//  Created by miaoxiaodong on 16/7/24.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import "XDMoneyInputView.h"
#import "UITextField+ExtentRange.h"

@interface XDMoneyInputView()<UITextFieldDelegate>

@end
@implementation XDMoneyInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSelfView];
    }
    return self;
}

- (void)setupSelfView
{
    self.backgroundColor = [UIColor whiteColor];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:self.bounds];
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = @"请输入支付金额";
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    [textField addTarget:self action:@selector(inputTextField:) forControlEvents:UIControlEventEditingChanged];
    UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, self.frame.size.height)];
    money.textColor = [UIColor lightGrayColor];
    money.font = [UIFont systemFontOfSize:20];
    money.text = @"￥";
    textField.leftView = money;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.delegate = self;
    [self addSubview:textField];
    self.moneyTextField = textField;
}

- (void)inputTextField:(UITextField *)textField
{
    if ([textField.text isEqualToString:@"."]) {
        textField.text = @"0.";
    }
    if ([textField.text rangeOfString:@"."].location != NSNotFound && textField.text.length - [textField.text rangeOfString:@"."].location > 3) {
        textField.text = [textField.text substringToIndex:textField.text.length - 1];
        return;
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"string = %@   =%@    =%@", string, NSStringFromRange(range)  ,  NSStringFromRange([textField selectedRange]));
    if ([string isEqualToString:@"."] && [textField.text rangeOfString:@"."].location != NSNotFound) {
        return NO;
    }
    if ([textField.text isEqualToString:@"0"] && [string isEqualToString:@"0"]) {
        return NO;
    }
    if ([textField selectedRange].location < textField.text.length - 2 && [string isEqualToString:@"."] && textField.text.length > 2) {
        return NO;
    }
    if ([textField selectedRange].location == 0 && [string isEqualToString:@"."] && textField.text.length) {
        textField.text = [NSString stringWithFormat:@"0.%@", textField.text];
        return NO;
    }
    if ([textField.text isEqualToString:@"0"] && ![string isEqualToString:@"."]) {
        textField.text = string;
        return NO;
    }
    
    
    return YES;
}

@end
