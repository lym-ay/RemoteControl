//
//  VoiceView.h
//  RemoteControl
//
//  Created by olami on 2017/7/20.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//


//这个页面定义了 语音输入的页面
#import <UIKit/UIKit.h>

typedef void (^CloseViewBlock)(void);

@interface VoiceView : UIView
@property (nonatomic, strong) CloseViewBlock block;
@end
