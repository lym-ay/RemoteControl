//
//  ProgramCollectionViewCell.m
//  RemoteControl
//
//  Created by olami on 2017/7/10.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "ProgramCollectionViewCell.h"
#import "ContentViewCollectionViewCell.h"
#import "SmallCollectionViewCell.h"
#import "Macro.h"
#import "ScheduleMode.h"


static NSString *commonID = @"CommonCell";
static NSString *smallID = @"SmallCommonCell";

@interface ProgramCollectionViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,retain) UICollectionView *collectionView;


@end

@implementation ProgramCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}




- (void)setupUI {
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Kwidth, Kheight) collectionViewLayout:layout];
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = YES;
    self.collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ContentViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:commonID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SmallCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:smallID];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ContentViewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:commonID forIndexPath:indexPath];
        NSMutableArray *arry = [ScheduleMode shareInstance].dataIsPlayingArry;
        if (arry) {
            ProgramData *data = arry[indexPath.row];
            if (data) {
                cell.programName.text = data.program_title;
                cell.channelName.text = data.channel_title;
            }
            
        }
        
        return cell;
        
    }
    
    SmallCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:smallID forIndexPath:indexPath];
    NSMutableArray *arry = [ScheduleMode shareInstance].dataIsPlayingArry;
    if (arry) {
        ProgramData *data = arry[indexPath.row];
        if (data) {
            cell.programName.text = data.program_title;
            cell.channelName.text = data.channel_title;
        }

    }
    
    return cell;
}



//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  [ScheduleMode shareInstance].dataIsPlayingArry.count;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return CGSizeMake(345, 179);
    }
    
    return CGSizeMake(168, 98);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 10, 15);//分别为上、左、下、右
}


- (void)reloadDatas {
    [_collectionView reloadData];
}
@end
