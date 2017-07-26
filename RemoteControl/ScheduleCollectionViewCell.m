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

@interface ScheduleCollectionViewCell()<UITableViewDelegate,UITableViewDataSource> {

}
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Kwidth, Kheight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
    [_tableView registerClass:[ScheduleHeaderView class] forHeaderFooterViewReuseIdentifier:KHeaderId];
    [_tableView registerNib:[UINib nibWithNibName:@"ScheduleTableViewCell" bundle:nil] forCellReuseIdentifier:ScheduleCell];

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


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ScheduleHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:KHeaderId];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}


@end
