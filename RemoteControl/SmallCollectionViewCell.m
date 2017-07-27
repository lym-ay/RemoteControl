//
//  SmallCollectionViewCell.m
//  RemoteControl
//
//  Created by olami on 2017/7/26.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "SmallCollectionViewCell.h"

@implementation SmallCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImage *img = [UIImage imageNamed:@"qb"];
    [_imgView setImage:img];
}

@end
