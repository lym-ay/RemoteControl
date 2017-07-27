//
//  SelectOperatorVC.m
//  RemoteControl
//
//  Created by olami on 2017/7/19.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "SelectOperatorVC.h"
#import "Macro.h"
#import "UserManager.h"
#import "OperatorViewCell.h"
#import "MBProgressHUD.h"

static NSString   *OperationCell              =  @"OperationViewTableViewCellId";
@interface SelectOperatorVC ()<UITableViewDelegate,UITableViewDataSource>{
    MBProgressHUD *hub;

}
@property (weak, nonatomic) IBOutlet UILabel *labelCityName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString            *cityName;
@property (nonatomic, copy) NSArray             *companyNameArry;
@property (nonatomic, copy) NSMutableArray      *cellArry;//保存所有生成的cell


@end

@implementation SelectOperatorVC


- (void)viewWillAppear:(BOOL)animated {
    _labelCityName.text = @"当前城市：上海";
    _companyNameArry = [[NSArray alloc] initWithArray:[UserManager shareInstance].companyNameArry];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}


- (void)setupUI {
    hub = [[MBProgressHUD alloc] initWithView:self.view];
    hub.label.text = @"初始化...";
    hub.mode = MBProgressHUDModeIndeterminate;
    [hub showAnimated:YES];
    [self.view addSubview:hub];
    
    [self performSelector:@selector(doneLoad) withObject:nil afterDelay:5];
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.allowsSelection = YES;
    [_tableView registerNib:[UINib nibWithNibName:@"OperatorViewCell" bundle:nil]  forCellReuseIdentifier:OperationCell];

}

- (void)doneLoad {
    [hub hideAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark--TableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _companyNameArry.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OperatorViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OperationCell];
    NSString *str = _companyNameArry[indexPath.row];
    cell.nameLabel.textColor = [UIColor blackColor];
    cell.nameLabel.text = str;
    [_cellArry addObject:cell];
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53*nKheight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (int i=0; i<_cellArry.count; i++) {
        OperatorViewCell *cell = _cellArry[i];
        [cell.button setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    }
    OperatorViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.button setImage:[UIImage imageNamed:@"float"] forState:UIControlStateNormal];
    
    [UserManager shareInstance].companyName = cell.nameLabel.text;
    
}



@end
