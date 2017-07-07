//
//  HotCollectionViewCell.h
//  RemoteControl
//
//  Created by olami on 2017/7/5.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "HotSearchCollectionViewCell.h"
#import "Macro.h"

@interface HotSearchCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *backView;


@end
@implementation HotSearchCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backView.layer.cornerRadius = 3.0f;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.borderColor = COLOR(122, 122, 122, 1).CGColor;
    self.backView.layer.borderWidth = 1.0f;

}

@end
