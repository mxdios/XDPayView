//
//  XDPayPasswordView.m
//  XDPayView
//
//  Created by miaoxiaodong on 16/7/24.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import "XDPayPasswordView.h"
#import "XDBanCheckAllTextField.h"
#import "UIView+Frame.h"

#define XDViewWidth [UIScreen mainScreen].bounds.size.width
#define XDViewHeight [UIScreen mainScreen].bounds.size.height
#define setAlpColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kBgGrayColor [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00]

@implementation XDPayPasswordView
{
    UIView *_payPassordView;
    UILabel *_gasInn;
    UILabel *_moneyLabel;
    NSMutableArray *_pswDotArray;
    XDBanCheckAllTextField *_textF;
}
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    _pswDotArray = [NSMutableArray array];
    
    self.frame = CGRectMake(0, 0, XDViewWidth, XDViewHeight);
    self.backgroundColor = setAlpColor(0, 0, 0, 0.5);
    
    _payPassordView = [[UIView alloc] init];
    _payPassordView.backgroundColor = kBgGrayColor;
    _payPassordView.layer.cornerRadius = 6;
    _payPassordView.width = 290;
    _payPassordView.centerX = self.width * 0.5;
    [self addSubview:_payPassordView];
    
    UILabel *tishi = [self setupLabel:@"请输入支付密码" frame:CGRectMake(0, 0, _payPassordView.width, 50) fontSize:18];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_payPassordView addSubview:closeBtn];
    
    UIView *line1 = [self setupLine:CGRectMake(0, tishi.bottom, _payPassordView.width, 1)];
    
    _gasInn = [self setupLabel:@"测试支付" frame:CGRectMake(0, line1.bottom + 20, _payPassordView.width, 18) fontSize:18];
    
    
    _moneyLabel = [self setupLabel:@"￥ 0.00" frame:CGRectMake(0, _gasInn.bottom + 10, _payPassordView.width, 50) fontSize:40];
    
    UIView *line2 = [self setupLine:CGRectMake(20, _moneyLabel.bottom + 10, _payPassordView.width - 40, 1)];
    
    _textF = [[XDBanCheckAllTextField alloc] initWithFrame:CGRectMake(20, line2.bottom + 10, line2.width, 45)];
    _textF.keyboardType = UIKeyboardTypeNumberPad;
    _textF.backgroundColor = [UIColor clearColor];
    _textF.textColor = [UIColor clearColor];
    [_textF addTarget:self action:@selector(inputTextField:) forControlEvents:UIControlEventEditingChanged];
    [_payPassordView addSubview:_textF];
    [_textF becomeFirstResponder];
    
    UIView *psw = [[UIView alloc] initWithFrame:CGRectMake(20, line2.bottom + 10, _payPassordView.width - 40, 45)];
    psw.userInteractionEnabled = NO;
    psw.backgroundColor = [UIColor whiteColor];
    psw.layer.borderColor = [UIColor grayColor].CGColor;
    psw.layer.borderWidth = 1;
    [_payPassordView addSubview:psw];
    
    CGFloat gridW = (psw.width - 0.5 * 5) / 6;
    for (NSInteger i = 0; i < 6; i ++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake((gridW + 0.5) * i + gridW, 0, 1, psw.height)];
        line.backgroundColor = [UIColor lightGrayColor];
        line.alpha = 0.5;
        [psw addSubview:line];
        
        UIView *pswDot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        pswDot.backgroundColor = [UIColor grayColor];
        pswDot.layer.cornerRadius = 5;
        pswDot.centerY = psw.height * 0.5;
        pswDot.centerX = line.x - gridW * 0.5;
        pswDot.hidden = YES;
        [psw addSubview:pswDot];
        [_pswDotArray addObject:pswDot];
        if (i == 5) {
            line.hidden = YES;
        }
    }
    
    _payPassordView.height = psw.bottom + 20;
    _payPassordView.centerY = self.height * 0.5;
}

- (void)setMoney:(NSString *)money
{
    _money = money;
    _moneyLabel.text = money;
}
- (void)inputTextField:(UITextField *)textField
{
    if (textField.text.length > 6){
        textField.text = [textField.text substringToIndex:6];
    }
    for (NSInteger i = 0; i < _pswDotArray.count; i++) {
        [_pswDotArray[i] setHidden:(textField.text.length == 0) || (textField.text.length - 1 < i)];
    }
    if (textField.text.length == 6) {
        if ([self.delegate respondsToSelector:@selector(passwordInputOver:payPasswordView:)]) {
            [self.delegate passwordInputOver:textField.text payPasswordView:self];
        }
        [self endEditing:YES];
    }
}
- (UILabel *)setupLabel:(NSString *)text frame:(CGRect)frame fontSize:(CGFloat)fontSize
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:(fontSize)];
    label.textColor = [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1.00];
    [_payPassordView addSubview:label];
    return label;
    
}
- (UIView *)setupLine:(CGRect)frame
{
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = [UIColor lightGrayColor];
    line.alpha = 0.5;
    [_payPassordView addSubview:line];
    return line;
}
- (void)closeBtnClick
{
    [self removeFromSuperview];
}

- (void)keyboardWillShow:(NSNotification *)not
{
    CGFloat keyboardH = [not.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [UIView animateWithDuration:0.5 animations:^{
        _payPassordView.centerY = (self.height - keyboardH) * 0.5;
    }];
    
}
- (void)keyboardWillHide:(NSNotification *)not
{
    [UIView animateWithDuration:0.5 animations:^{
        _payPassordView.centerY = self.height * 0.5;
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.delegate = nil;
}


@end
