//
//  ScheduleHeaderView.h
//  RemoteControl
//
//  Created by olami on 2017/7/10.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import <UIKit/UIKit.h>

//UITableView的头部，用来显示星期几

typedef void(^buttonBlock)(void);

@interface ScheduleHeaderView : UITableViewHeaderFooterView
@property (nonatomic, copy) buttonBlock block;
@end
