//
//  ScheduleHeaderView.m
//  RemoteControl
//
//  Created by olami on 2017/7/10.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "ScheduleHeaderView.h"
#import "Macro.h"

@interface ScheduleHeaderView()
@property (nonatomic, strong) NSMutableArray *arry;//用来保存生成的button
@end

@implementation ScheduleHeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Kwidth, 1)];
    headerView.backgroundColor = COLOR(204, 204, 204, 1);
    [self addSubview:headerView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, Kwidth, 1)];
    footerView.backgroundColor = COLOR(204, 204, 204, 1);
    [self addSubview:footerView];
    
    NSArray *array = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    _arry = [[NSMutableArray alloc] init];
    for (int i=0; i<7; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15+i*50, 25, 50, 20);
        [_arry addObject:button];
        [self addSubview:button];
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:FONTFAMILY size:16];
        [button setTitleColor:COLOR(153, 153, 153, 1) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
}

- (void)buttonAction:(UIButton *)button {
    for (int i=0; i<7; i++) {
        UIButton *tmp = _arry[i];
        [tmp setTitleColor:COLOR(153, 153, 153, 1) forState:UIControlStateNormal];
        tmp.backgroundColor = [UIColor clearColor];
    }
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = COLOR(117, 197, 239, 1);
}

@end
