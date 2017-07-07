//
//  SearchView.m
//  RemoteControl
//
//  Created by olami on 2017/7/7.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "SearchView.h"
#import "HotSearchTableViewCell.h"
#import "SearchHistoryRecordfooter.h"
#import "SearchRecordTableViewCell.h"
#import "Macro.h"


#define KsearchRecordCellId @"SearcgRecodeCell"
#define KHotSearchCellId @"KHotSearchCell"
#define KHotSearchFooterClass @"SearchHistoryRecordfooter"
#define KHotsearchFooterId @"HotSearchFooter"
#define KHotsearchFooterId2 @"HotSearchFooter2"
#define KSearchRecordArr @"KsearchRecordArr"//搜索的记录


@interface SearchView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *SearchTableView;//搜索的记录
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *HotDataArr;
@property (nonatomic, assign) BOOL isChange;
@end

@implementation SearchView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadingData];
    }
    
    return self;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (NSMutableArray *)HotDataArr{
    if (!_HotDataArr) {
        _HotDataArr = [NSMutableArray new];
    }
    return _HotDataArr;
}
-(UITableView *)SearchTableView{
    if (!_SearchTableView) {
        
        _SearchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Kwidth, Kheight-64) style:UITableViewStylePlain];
        _SearchTableView.delegate = self;
        _SearchTableView.dataSource = self;
        [self addSubview:_SearchTableView];
        [_SearchTableView registerClass:[SearchRecordTableViewCell class] forCellReuseIdentifier:KsearchRecordCellId];
        [_SearchTableView registerClass:[HotSearchTableViewCell class] forCellReuseIdentifier:KHotSearchCellId];
        [_SearchTableView registerNib:[UINib nibWithNibName:KHotSearchFooterClass bundle:nil] forHeaderFooterViewReuseIdentifier:KHotsearchFooterId];
        [_SearchTableView registerNib:[UINib nibWithNibName:KHotSearchFooterClass bundle:nil] forHeaderFooterViewReuseIdentifier:KHotsearchFooterId2];
        _SearchTableView.backgroundColor = [UIColor blueColor];
    }
    return _SearchTableView;
}

- (void)loadingData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [defaults objectForKey:KSearchRecordArr];
    if ((!(arr.count==0))&&(![arr isKindOfClass:[NSNull class]])) {
        
        //self.HistoryFooter.deleteBtn.enabled = YES;
        self.dataArr = [arr mutableCopy];
    }
    
    NSArray *array = @[@"鞋子发送的飞洒发的撒大师法第三方",@"全球时尚",@"天天搞机",@"苏宁易购",@"好",@"热门推荐内容",@"猜你喜欢"];
    [self.HotDataArr addObject:array];
    [self.SearchTableView reloadData];
}

- (void)deleteBtnAction:(UIButton *)sender{
    
}


//重写手势的方法 手势会影响 cell的点击
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        
        return NO;
    }else{
        return YES;
    }
    
}


#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataArr.count;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0 ) {
        SearchRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KsearchRecordCellId];
        if (self.dataArr.count!=0) {
            cell.labeText.text = self.dataArr[self.dataArr.count-1-indexPath.row];
        }
        return cell;
    }else{
        HotSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KHotSearchCellId];
        if (self.HotDataArr.count !=0) {
            if (self.isChange == NO) {
                [cell infortdataArr:[self.HotDataArr firstObject]];
            }else{
                [cell infortdataArr:[self.HotDataArr lastObject]];
            }
            
            cell.block = ^(NSInteger index){
                //                SearchViewController *search = [SearchViewController new];
                //                search.title = self.HotDataArr[index];
                //                [self.navigationController pushViewController:search animated:YES];
                NSLog(@"index is %ld",index);
            };
        }
        //        cell.DBlock =^{
        //            [self.BYsearchTextFd resignFirstResponder];
        //        };
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 45;
    }else{
        return 300;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        SearchHistoryRecordfooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:KHotsearchFooterId];
        footer.img.image = [UIImage imageNamed:@"历史搜索"];
        footer.labelHis.text = @"历史搜索";
        UIButton *Deletbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        Deletbtn.frame = CGRectMake(self.frame.size.width-50,0,40, 45);
        [Deletbtn setImage:[UIImage imageNamed:@"历史删除"] forState:UIControlStateNormal];
        [footer addSubview:Deletbtn];
        [Deletbtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide:)];
        [footer addGestureRecognizer:tap];
        return footer;
    }else{
        SearchHistoryRecordfooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:KHotsearchFooterId2];
        footer.img.image = [UIImage imageNamed:@"热门搜索"];
        footer.labelHis.text = @"热门搜索";
        UIButton *ChangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        ChangeBtn.frame = CGRectMake(self.frame.size.width-80,0, 60,45);
        [ChangeBtn setTitle:@"换一批" forState:UIControlStateNormal];
        [ChangeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [footer addSubview:ChangeBtn];
        [ChangeBtn addTarget:self action:@selector(changeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide:)];
        [footer addGestureRecognizer:tap];
        return footer;
    }
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width,1)];
    if (section == 0) {
        
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(15, 0, self.frame.size.width-15, 1)];
        view1.backgroundColor = COLOR(123, 123, 123, 1);
        [footerView addSubview:view1];
    }
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return 45;
        
    }else{
        return 45;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        
    }
    
}




@end
