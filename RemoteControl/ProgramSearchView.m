//
//  ProgramSearchView.m
//  RemoteControl
//
//  Created by olami on 2017/7/10.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "ProgramSearchView.h"
#import "RCHeaderChooseViewScrollView.h"
#import "ProgramCollectionViewCell.h"
#import "ScheduleCollectionViewCell.h"
#import "Macro.h"



@interface ProgramSearchView()<UICollectionViewDelegate,UICollectionViewDataSource>{
//    ProgramCollectionViewCell * cell;
}
@property (nonatomic ,retain) UICollectionView *collectionView;
@property (nonatomic ,retain) NSMutableArray *tagArray;
@property (nonatomic ,retain) RCHeaderChooseViewScrollView  *headerView;
@end


static NSString *programID = @"ProgramItemCell";
static NSString *scheduleID = @"ScheduleItemCell";
static NSString *sectionHeaderID = @"sectionHeader";

@implementation ProgramSearchView

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createNav];
        [self createCollectionView];
    }
    
    return self;
}

-(void)createNav{
    NSArray *array=@[
                     @"正在播放",
                     @"播出时间"
                    ];
    self.tagArray =[NSMutableArray arrayWithArray:array];
    
    self.headerView=[[RCHeaderChooseViewScrollView alloc]initWithFrame:CGRectMake(0, 0, Kwidth, 32)];
    self.headerView.backgroundColor = COLOR(245, 245, 245, 1);
    
    [self addSubview:self.headerView];
    
    [self.headerView setUpTitleArray:array titleColor:COLOR(51, 51, 51, 1) titleSelectedColor:COLOR(42, 161, 222, 1) titleFontSize:16];
    __weak typeof(self) weakSelf = self;
    self.headerView.btnChooseClickReturn = ^(NSInteger x) {
       [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:x inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    };
    
    
}

-(void)createCollectionView{
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = self.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 32, Kwidth, self.frame.size.height) collectionViewLayout:layout];
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = YES;
    self.collectionView.pagingEnabled = YES;
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[ProgramCollectionViewCell class] forCellWithReuseIdentifier:programID];
    [self.collectionView registerClass:[ScheduleCollectionViewCell class] forCellWithReuseIdentifier:scheduleID];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.tagArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0: {
            ProgramCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:programID forIndexPath:indexPath];
            [cell reloadDatas];
          
            return cell;
        }
            
            break;
        case 1: {
            ScheduleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:scheduleID forIndexPath:indexPath];
            [cell reloadDatas];
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offsetx =scrollView.contentOffset.x;
    NSInteger index = offsetx/Kwidth;
    [self.headerView scollToCurrentButtonWithIndex:index];
    
}

- (void)reloadDatas {
    [_collectionView reloadData];
}

@end
