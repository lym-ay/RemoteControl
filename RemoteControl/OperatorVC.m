//
//  OperatorVC.m
//  RemoteControl
//
//  Created by olami on 2017/7/5.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "OperatorVC.h"
#import "ViewController.h"
#import "Macro.h"
#import "InfraredData.h"
#import "OperatorViewCell.h"
#import "MBProgressHUD.h"
#import "UserManager.h"
#import <CoreLocation/CoreLocation.h>



static NSString   *OperationCell              =  @"OperationViewTableViewCellId";

@interface OperatorVC ()<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>{
    MBProgressHUD *hub;
}

@property (weak, nonatomic) IBOutlet UIButton *goBtn;
@property (weak, nonatomic) IBOutlet UILabel *labelCityName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) NSString            *cityName;
@property (nonatomic, copy) NSArray      *companyNameArry;
@property (nonatomic, copy) NSMutableArray      *cellArry;//保存所有生成的cell

@end

@implementation OperatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _goBtn.layer.masksToBounds = YES;
    _goBtn.layer.cornerRadius = _goBtn.bounds.size.width/2;
    _goBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _goBtn.layer.borderWidth = 1;
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    
    
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager requestWhenInUseAuthorization];
    }
    
    [_locationManager startUpdatingLocation];
    
    _labelCityName.alpha = 0.6;
    
    [self initData];
    
    hub = [[MBProgressHUD alloc] initWithView:self.view];
    hub.label.text = @"初始化...";
    hub.mode = MBProgressHUDModeIndeterminate;
    [hub showAnimated:YES];
    [self.view addSubview:hub];
    
    [self performSelector:@selector(doneLoad) withObject:nil afterDelay:5];

}


- (void)initData {
    [InfraredData sharedInfraredData].dbName = DBName;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    [[InfraredData sharedInfraredData] parserJSON:data];
    
    [self getCompanyInfo:nil];
    
    
    _cellArry = [[NSMutableArray alloc] init];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.allowsSelection = YES;
    [_tableView registerNib:[UINib nibWithNibName:@"OperatorViewCell" bundle:nil]  forCellReuseIdentifier:OperationCell];
    
}




-(void)getCompanyInfo:(NSData*)jsonFile {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"compnay" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        NSLog(@"error is %@",err.localizedDescription);
        return;
    }
    
    NSString *provice = [dic objectForKey:@"province"];
    NSString *version = [dic objectForKey:@"version"];
    NSArray *arry = [dic objectForKey:@"support"];
    NSMutableArray *tmpArry = [[NSMutableArray alloc] init];
    for (int i=0; i<arry.count; i++) {
        NSDictionary *tmpDic = arry[i];
        [tmpArry addObject:[tmpDic objectForKey:@"company"]];
    }
    _companyNameArry = [[NSArray alloc] initWithArray:tmpArry];
    [UserManager shareInstance].companyNameArry = [[NSArray alloc] initWithArray:_companyNameArry];
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doneLoad {
    [hub hideAnimated:YES];
}

- (IBAction)goNextViewControllerAction:(id)sender {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* mainVC =[mainStoryBoard instantiateViewControllerWithIdentifier:@"mainSID"];
    [self presentViewController:mainVC animated:YES completion:nil];
}


#pragma mark CoreLocation delegate
/*定位失败则执行此代理方法*/
/*定位失败弹出提示窗，点击打开定位按钮 按钮，会打开系统设置，提示打开定位服务*/
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败!");
    /*设置提示提示用户打开定位服务*/
    //    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertAction * ok =[UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //        /*打开定位设置*/
    //        NSURL * settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    //        [[UIApplication sharedApplication]openURL:settingsURL];
    //    }];
    //    UIAlertAction * cacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    [alert addAction:ok];
    //    [alert addAction:cacel];
    //[self presentViewController:alert animated:YES completion:nil];
}
/*定位成功后则执行此代理方法*/
#pragma mark 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [_locationManager stopUpdatingLocation];
    /*旧值*/
    CLLocation * currentLocation = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc]init];
    
    /*地理反编码 -- 可以根据地理位置（经纬度）确认位置信息 （街道、门牌）*/
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count >0) {
            CLPlacemark * placeMark = placemarks[0];
            _cityName = placeMark.locality;
            NSLog(@"city is %@",_cityName);
            [UserManager shareInstance].cityName = _cityName;
            NSString *str = [NSString stringWithFormat:@"当前城市:%@",_cityName];
            _labelCityName.text = str;
            
        }
        else if (error == nil&&placemarks.count == 0){
            NSLog(@"没有地址返回");
        }
        else if (error){
            NSLog(@"location error:%@",error);
        }
    }];
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
