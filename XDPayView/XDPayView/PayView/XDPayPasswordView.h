//
//  XDPayPasswordView.h
//  XDPayView
//
//  Created by miaoxiaodong on 16/7/24.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XDPayPasswordView;
@protocol XDPayPasswordViewDelegate <NSObject>

- (void)passwordInputOver:(NSString *)password payPasswordView:(XDPayPasswordView *)payPasswordView;

@end

@interface XDPayPasswordView : UIView
@property (nonatomic, weak) id<XDPayPasswordViewDelegate> delegate;

@property (nonatomic, copy)NSString *money;
@end
