//
//  SearchView.h
//  RemoteControl
//
//  Created by olami on 2017/7/25.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^showTools)(void);

//搜索页面和显示搜索结果的页面 SearchTableView ProgramSearchView为其子页面
@interface SearchView : UIView
@property (nonatomic, copy)showTools showBlock;
@end
