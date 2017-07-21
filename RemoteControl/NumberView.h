//
//  NumberView.h
//  RemoteControl
//
//  Created by olami on 2017/7/20.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//


//用来显示数字键盘
#import <UIKit/UIKit.h>

typedef void (^CloseViewBlock)(void);

@interface NumberView : UIView
@property (nonatomic, strong) CloseViewBlock block;
@end
