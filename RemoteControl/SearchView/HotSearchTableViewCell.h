//
//  HotSearchTableViewCell.h
//  RemoteControl
//
//  Created by olami on 2017/7/7.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BYDBlock)(void);
typedef void(^Myblock) (NSInteger index);
@interface HotSearchTableViewCell : UITableViewCell

- (void)infortdataArr:(NSMutableArray *)arr;
@property (nonatomic,strong) Myblock block;
@property (nonatomic,strong) BYDBlock DBlock;
@end
