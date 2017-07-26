//
//  NavigationView.m
//  RemoteControl
//
//  Created by olami on 2017/7/7.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "NavigationView.h"
#import "RCHeaderChooseViewScrollView.h"
#import "NaviagtionCollectionViewCell.h"
#import "HotCollectionViewCell.h"
#import "Macro.h"
 

@interface NavigationView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,retain) UICollectionView *collectionView;
@property (nonatomic ,retain) NSMutableArray *tagArray;
@property (nonatomic ,retain) RCHeaderChooseViewScrollView  *headerView;
@end


static NSString *navigationID = @"navigationCell";

@implementation NavigationView

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createNav];
        [self createCollectionView];
    }
    
    return self;
}

-(void)createNav{
    NSArray *array=@[
                     @"热门",
                     @"本地",
                     @"央视",
                     @"卫视",
                     @"影视",
                     @"新闻",
                     @"体育",
                     @"综艺",
                     @"生活",
                     @"科教",
                     @"音乐",
                     @"少儿",
                     @"其它"
                     ];
    self.tagArray =[NSMutableArray arrayWithArray:array];
    
    self.headerView=[[RCHeaderChooseViewScrollView alloc]initWithFrame:CGRectMake(0, 0, Kwidth, 32)];
    self.headerView.backgroundColor = COLOR(245, 245, 245, 1);
    [self addSubview:self.headerView];
    
    [self.headerView setUpTitleArray:array titleColor:[UIColor blackColor] titleSelectedColor:COLOR(42, 161, 222, 1) titleFontSize:16];
    __weak typeof(self) weakSelf = self;
    self.headerView.btnChooseClickReturn = ^(NSInteger x) {
        NSLog(@"点击了第%ld个按钮",x+1);
        [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:x inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    };
    
    
}

-(void)createCollectionView{
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 32, Kwidth, self.frame.size.height) collectionViewLayout:layout];
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = YES;
    self.collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[NaviagtionCollectionViewCell class] forCellWithReuseIdentifier:navigationID];
 
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _tagArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            NaviagtionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:navigationID forIndexPath:indexPath];
            return  cell;
        }
            
            break;
        case 1: {
           NaviagtionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:navigationID forIndexPath:indexPath];
           return cell;
            
        }
            break;
         
        default:
            break;
    }
    
    NaviagtionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:navigationID forIndexPath:indexPath];
    return cell;
    
    return nil;
   
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(Kwidth, self.frame.size.height);
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetx =scrollView.contentOffset.x;
    NSInteger index = offsetx/Kwidth;
    [self.headerView scollToCurrentButtonWithIndex:index];
    
}



@end
