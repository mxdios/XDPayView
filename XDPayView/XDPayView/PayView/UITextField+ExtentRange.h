//
//  UITextField+ExtentRange.h
//  XDPayView
//
//  Created by miaoxiaodong on 16/7/23.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtentRange)
/**
 *  获取光标位置
 */
- (NSRange)selectedRange;
/**
 *  设置光标位置
 */
- (void)setSelectedRange:(NSRange) range;

@end
