//
//  NumberView.m
//  RemoteControl
//
//  Created by olami on 2017/7/20.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "NumberView.h"
#import "Macro.h"
#import "Masonry.h"

#define WIDTHPADDING 29
#define HEIGHTPADDING 25

@interface NumberView(){
    NSInteger tmpNum;
}
@property (nonatomic, strong) UILabel        *numLabel;
@property (nonatomic, strong) NSMutableArray *buttonArry;//用来保存所有生成的button

@end

@implementation NumberView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {
    self.backgroundColor = COLOR(26, 49, 67, 1);
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:cancleBtn];
    [cancleBtn setImage:[UIImage imageNamed:@"voiceBack"] forState:UIControlStateNormal];
    [cancleBtn setBackgroundColor:COLOR(35, 68, 93, 1)];
    [cancleBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(605, 0, 0, 0));
    }];
    
    _numLabel = [[UILabel alloc] init];
    [self addSubview:_numLabel];
    _numLabel.textAlignment = NSTextAlignmentRight;
    _numLabel.textColor = COLOR(255, 255, 255, 1);
    _numLabel.font = [UIFont fontWithName:FONTFAMILY size:64];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(75, 0, 528, 58));
    }];
    
    _buttonArry = [[NSMutableArray alloc] init];
    
    for (int i=0,j=0,k=0; i<12; i++,k++) {
        
        if (i/3 !=0 && k/3 != 0) {
            j=(i/3);
            k = 0;
        }
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(51+k*(72+WIDTHPADDING), 191+j*(72+HEIGHTPADDING), 72, 72)];
        button.layer.borderColor = COLOR(42, 161, 222, 1).CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = button.bounds.size.width/2;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont fontWithName:FONTFAMILY size:34];
        
        if (i<9) {
             [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        }else if (i==9) {
            [button setTitle:@"清除" forState:UIControlStateNormal];
             button.titleLabel.font = [UIFont fontWithName:FONTFAMILY size:20];
        }else if (i==10) {
            [button setTitle:@"0" forState:UIControlStateNormal];
        }else if (i==11) {
            [button setTitle:@"确定" forState:UIControlStateNormal];
             button.titleLabel.font = [UIFont fontWithName:FONTFAMILY size:20];
        }
       
       
        button.tag = i+100;
        [_buttonArry addObject:button];
        [button addTarget:self action:@selector(buttonNumberAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        tmpNum = 0;
    }
    
 
}


- (void)backAction:(UIButton *)button {
    self.block();
}


- (void)buttonNumberAction:(UIButton*)button {
    for (int i=0; i<_buttonArry.count; i++) {
        UIButton *btn = _buttonArry[i];
        btn.backgroundColor = [UIColor clearColor];
    }
    
    button.backgroundColor = COLOR(42, 161, 222, 1);
    
    [UIView animateWithDuration:0.1 animations:^{
        button.backgroundColor = [UIColor clearColor];
    }];
    
    if (button.tag == 109) {//清除按钮
        tmpNum =0;
        _numLabel.text = @"";
       
        
        //button.layer.backgroundColor = [UIColor clearColor].CGColor;

        
    }else if (button.tag == 111) {//确定按钮
         
    }else if (button.tag == 110){// 0
        if (tmpNum) {
            tmpNum *= 10;
            NSString *str = [NSString stringWithFormat:@"%ld",tmpNum];
            _numLabel.text = str;
        }else{
            _numLabel.text = @"0";
        }
    }else {
        if (tmpNum == 0) {
            tmpNum = button.tag-99;
            NSString *str = [NSString stringWithFormat:@"%ld",tmpNum];
            _numLabel.text = str;
        }else {
            tmpNum *= 10;
            tmpNum += button.tag-99;
            NSString *str = [NSString stringWithFormat:@"%ld",tmpNum];
            _numLabel.text = str;
            
            
        }
       
        
    }
    
}

@end
