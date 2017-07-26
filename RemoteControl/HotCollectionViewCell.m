//
//  HotCollectionViewCell.m
//  RemoteControl
//
//  Created by olami on 2017/7/25.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "HotCollectionViewCell.h"
#import "ContentViewCollectionViewCell.h"
#import "Macro.h"

static NSString *reuseID = @"itemCell";
@interface HotCollectionViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,retain) UICollectionView *collectionView;

@end

@implementation HotCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSLog(@"hotCell");
        [self setupUI];
    }
    
    return self;
}




- (void)setupUI {
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = self.bounds.size;
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
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ContentViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseID];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ContentViewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    return cell;
}



//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 11;
    
}




//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return CGSizeMake(345, 179);
    }
    
    return CGSizeMake(168, 98);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 5, 15);//分别为上、左、下、右
}

@end
