//
//  ScheduleTableViewCell.m
//  RemoteControl
//
//  Created by olami on 2017/7/26.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "ScheduleTableViewCell.h"

@interface ScheduleTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *channelLabel;
@property (weak, nonatomic) IBOutlet UILabel *programNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ScheduleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonAction:(id)sender {
}

@end
