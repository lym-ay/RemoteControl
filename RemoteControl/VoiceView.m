//
//  VoiceView.m
//  RemoteControl
//
//  Created by olami on 2017/7/20.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "VoiceView.h"
#import "Masonry.h"
#import "Macro.h"

@implementation VoiceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {
    self.backgroundColor = COLOR(24, 49, 69, 1);
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(15, 30, 30, 30);
    [self addSubview:cancleBtn];
    [cancleBtn setImage:[UIImage imageNamed:@"voiceBack"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.frame = CGRectMake(15, 30, 30, 30);
    [self addSubview:okButton];
    [okButton addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];

    
}


- (void)backAction:(UIButton *)button {
    self.block();
}

- (void)okAction:(UIButton *)button {
    
}

@end
