//
//  ViewController.m
//  RemoteControl
//
//  Created by olami on 2017/6/30.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "ViewController.h"
#import "InfraredData.h"
#import "OperatorView.h"
#import "Macro.h"
#import "HotCollectionViewCell.h"
#import "RCHeaderChooseViewScrollView.h"
#import "SearchView.h"

static NSString *reuseID = @"itemCell";
static NSString *sectionHeaderID = @"sectionHeader";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    SearchView *searchView;
}
@property (nonatomic ,retain) UICollectionView *collectionView;

@property (nonatomic ,retain) NSMutableArray *tagArray;

@property (nonatomic ,retain) RCHeaderChooseViewScrollView  *headerView;

@end

@implementation ViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self initData];
    
//    OperatorView *opView = [[OperatorView alloc] initWithFrame:CGRectMake(0, 0, Kwidth, Kheight)];
//    opView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:opView];
    
    [self createNav];
    [self createCollectionView];
    
    searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, Kwidth, Kheight)];
    searchView.hidden = YES;
    [self.view addSubview:searchView];
 
}
- (IBAction)buttonAction:(id)sender {
    searchView.hidden = NO;
}

- (void)initData {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *pulseDBName = [userDefaultes objectForKey:@"pulseDBName"];
    if (!pulseDBName) {
        [[InfraredData sharedInfraredData] parserXML];
        NSString *dbName = [InfraredData sharedInfraredData].dbName;
        [userDefaultes setObject:dbName forKey:@"pulseDBName"];
    }else{
        [InfraredData sharedInfraredData].dbName = pulseDBName;
    }
    

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
    
    self.headerView=[[RCHeaderChooseViewScrollView alloc]initWithFrame:CGRectMake(0, 88, Kwidth, 32)];

    [self.view addSubview:self.headerView];
    
    [self.headerView setUpTitleArray:array titleColor:nil titleSelectedColor:nil titleFontSize:0];
    __weak typeof(self) weakSelf = self;
    self.headerView.btnChooseClickReturn = ^(NSInteger x) {
        NSLog(@"点击了第%ld个按钮",x+1);
        [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:x inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    };
    
    
}

-(void)createCollectionView{
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = self.view.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 120, Kwidth, Kheight) collectionViewLayout:layout];
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = YES;
    self.collectionView.pagingEnabled = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[HotCollectionViewCell class] forCellWithReuseIdentifier:reuseID];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.tagArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    cell.backgroundColor = RandomColor;
    return cell;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat offsetx =scrollView.contentOffset.x;
    NSInteger index = offsetx/Kwidth;
    [self.headerView scollToCurrentButtonWithIndex:index];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
