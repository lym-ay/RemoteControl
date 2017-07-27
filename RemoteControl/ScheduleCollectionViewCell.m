//
//  ScheduleCollectionViewCell.m
//  RemoteControl
//
//  Created by olami on 2017/7/10.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "ScheduleCollectionViewCell.h"
#import "ScheduleHeaderView.h"
#import "ScheduleTableViewCell.h"
#import "Macro.h"


#define KHeaderId @"HotHeaderHeader"
#define ScheduleCell @"ScheduleTableViewCell"

@interface ScheduleCollectionViewCell()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *arry;//用来保存生成的button
@property (nonatomic, strong) UITableView *tableView;//搜索的记录
@end

@implementation ScheduleCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
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

    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 61, Kwidth, Kheight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
    //[_tableView registerClass:[ScheduleHeaderView class] forHeaderFooterViewReuseIdentifier:KHeaderId];
    [_tableView registerNib:[UINib nibWithNibName:@"ScheduleTableViewCell" bundle:nil] forCellReuseIdentifier:ScheduleCell];

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



#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ScheduleCell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    ScheduleHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:KHeaderId];
//    view.block = ^{
//        NSLog(@"header block");
//        [tableView reloadData];
//    };
//    return view;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 60;
//}


@end
