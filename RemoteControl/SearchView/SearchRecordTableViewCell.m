//
//  RCHeaderChooseViewScrollView.m
//  RemoteControl
//
//  Created by olami on 2017/7/5.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "SearchRecordTableViewCell.h"

@implementation SearchRecordTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat Width = [UIScreen mainScreen].bounds.size.width;
        self.labeText = [[UILabel alloc]initWithFrame:CGRectMake(15, 15,Width-30, 15)];
        self.labeText.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.labeText];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
