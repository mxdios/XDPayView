# XDPayView

代码实现金额输入框，添加约束金额的输入限制。

- 只能输入一位小数点
- 第一位是0，第二位不是小数点自动覆盖0
- 小数点后最多只能输入两位数字
- 第一位输入小数点，前面自动补0

代码实现密码输入框

- 密码输入完成检测密码正确性
- 密码只能输入6位数字
- 密码输入错误可重新点击密码输入框输入
- 不允许输入框密码拷贝
- 密码密文处理

用法: `PayView`文件夹 导入项目中。

添加金额输入框

```
XDMoneyInputView *moneyTextField = [[XDMoneyInputView alloc] initWithFrame:CGRectMake(30, 50, self.view.frame.size.width - 60, 50)];
    [self.view addSubview:moneyTextField];
```

添加密码输入框

```
XDPayPasswordView *payPasswordView = [[XDPayPasswordView alloc] init];
payPasswordView.delegate = self; //设置代理
payPasswordView.money = @"0.01"; //支付金额
[self.view.window addSubview:payPasswordView];
```

实现密码输入框代理方法

```
- (void)passwordInputOver:(NSString *)password payPasswordView:(XDPayPasswordView *)payPasswordView
{
    NSLog(@"密码 = %@", password); //检测密码正确与否
    [payPasswordView removeFromSuperview]; //移除密码输入框
}
```

![image](http://oalg33nuc.bkt.clouddn.com/image/QQ20160724-0.png)


![image](http://oalg33nuc.bkt.clouddn.com/image/QQ20160724-1.png)