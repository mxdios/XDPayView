//
//  XDBanCheckAllTextField.m
//  XDPayView
//
//  Created by miaoxiaodong on 16/7/24.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import "XDBanCheckAllTextField.h"

@implementation XDBanCheckAllTextField

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
