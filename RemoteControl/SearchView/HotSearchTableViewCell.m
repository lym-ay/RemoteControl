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
        _HotCollectionView.backgroundColor = [UIColor redColor];
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
    
    self.block(indexPath.row);
    
}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KSearchHotFooterId forIndexPath:indexPath];
//    footer.backgroundColor = [UIColor clearColor];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(KeyBoardHide:)];
//    [footer addGestureRecognizer:tap];
//    return footer;
//}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(self.frame.size.width, 300);
}

@end
