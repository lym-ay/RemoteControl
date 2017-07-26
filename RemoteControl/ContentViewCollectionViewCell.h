//
//  ContentViewCollectionViewCell.h
//  RemoteControl
//
//  Created by olami on 2017/7/25.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *programName;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *channelName;

@end
