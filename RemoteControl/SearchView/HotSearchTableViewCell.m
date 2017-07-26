//
//  HotSearchTableViewCell.m
//  RemoteControl
//
//  Created by olami on 2017/7/7.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "HotSearchTableViewCell.h"
#import "HotSearchCollectionViewCell.h"

#define KHotSearchCollectClass @"HotSearchCollectionViewCell"
#define KHotSearchCellId @"HotSearchCellId"
#define KSearchHotFooterId @"HotSearchFooter"

@interface HotSearchTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UICollectionView *HotCollectionView;
@end
@implementation HotSearchTableViewCell
- (UICollectionView *)HotCollectionView{
    if (!_HotCollectionView) {
        UICollectionViewFlowLayout *layOut = [UICollectionViewFlowLayout new];
        _HotCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,300) collectionViewLayout:layOut];
        //这是重点 自动适应
        layOut.estimatedItemSize = CGSizeMake(10, 10);
        layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
        layOut.minimumInteritemSpacing = 15;
        layOut.minimumLineSpacing = 15;
        _HotCollectionView.delegate = self;
        _HotCollectionView.dataSource = self;
        _HotCollectionView.scrollEnabled = NO;
        _HotCollectionView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_HotCollectionView];
        [_HotCollectionView registerNib:[UINib nibWithNibName:KHotSearchCollectClass bundle:nil] forCellWithReuseIdentifier:KHotSearchCellId];
//        [_HotCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KSearchHotFooterId];
    }
    return _HotCollectionView;
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (void)infortdataArr:(NSMutableArray *)arr{
    
    self.dataArr = arr;
    [self.HotCollectionView reloadData];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)KeyBoardHide:(UITapGestureRecognizer *)tap{
    
    self.DBlock();
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KHotSearchCellId forIndexPath:indexPath];
    if (self.dataArr.count !=0) {
        cell.labeltitle.text = self.dataArr[indexPath.row];
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(20,30);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15,15, 15, 15);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HotSearchCollectionViewCell *cell =(HotSearchCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    NSString *str = cell.labeltitle.text;
    self.block(str);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(self.frame.size.width, 300);
}

@end
