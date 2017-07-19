//
//  OperatorViewCell.m
//  RemoteControl
//
//  Created by olami on 2017/7/19.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "OperatorViewCell.h"

@interface OperatorViewCell()


@end

@implementation OperatorViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
