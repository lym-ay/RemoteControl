//
//  ViewController.m
//  RemoteControl
//
//  Created by olami on 2017/6/30.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "ViewController.h"
#import "InfraredData.h"
#import "Macro.h"
#import "SearchView.h"
#import "NavigationView.h"
#import "ProgramSearchView.h"
#import "SearchTextField.h"
#import "Masonry.h"
#import "VoiceView.h"
#import "NumberView.h"
#import "WaveService.h"
#import "UserManager.h"





@interface ViewController ()<UITextFieldDelegate,VoiceViewDelegate>{
    SearchView          *searchView;
    NavigationView      *navigationView;
    ProgramSearchView   *programSearchView;
    
}
@property (nonatomic, strong) SearchTextField *searchField;
@property (nonatomic, strong) VoiceView       *voiceView;
@property (nonatomic, strong) NumberView      *numberView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIView *voiceBackView;//用来保存VoiceView界面
@property (weak, nonatomic) IBOutlet UIView *mainBackView;//用来保存显示的界面的图片
@property (weak, nonatomic) IBOutlet UIView *searchFieldBackView;




@end

@implementation ViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (IBAction)buttonAction:(id)sender {
//    searchView.hidden = NO;
}



- (void)setupUI {
    //添加搜索view
    _searchField = [[SearchTextField alloc] init];
    _searchField.delegate = self;
    _searchField.layer.borderWidth =1;
    _searchField.layer.borderColor = COLOR(204, 204, 204, 204).CGColor;
    _searchField.layer.cornerRadius = 5;
    _searchField.layer.masksToBounds = YES;
    [_searchFieldBackView addSubview:_searchField];
    _searchField.placeholder  = @"搜索电视节目/频道";
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchIcon"]];
    img.frame = CGRectMake(10, 0, 20, 20);
    _searchField.leftView = img;
    _searchField.leftViewMode = UITextFieldViewModeAlways;
    
 
    UIButton *numberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    numberButton.frame = CGRectMake(0, 0, 32, 20);
    [numberButton setImage:[UIImage imageNamed:@"rectangle12"] forState:UIControlStateNormal];
    [numberButton addTarget:self action:@selector(openNumberView) forControlEvents:UIControlEventTouchUpInside];
    _searchField.rightView = numberButton;
    _searchField.rightViewMode = UITextFieldViewModeAlways;
    [_searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(6, 15, 6, 15));
    }];
 
    
    //录音界面
    _voiceView = [[VoiceView alloc] initWithFrame:_voiceBackView.frame];
    _voiceBackView.backgroundColor = COLOR(24, 49, 69, 1);
    _voiceView.delegate = self;
//    __weak typeof(self) weakSelf = self;
//    _voiceView.block= ^{
//        [UIView animateWithDuration:0.5 animations:^{
//            weakSelf.voiceView.frame = CGRectMake(0, Kheight, Kwidth, Kheight);
//        }];
//    };
    [_voiceBackView addSubview:_voiceView];
    
    
    //数字键盘界面
    _numberView = [[NumberView alloc] initWithFrame:CGRectMake(0, Kheight, Kwidth, Kheight)];
    __weak typeof(self) weakSelf1 = self;
    _numberView.block= ^{
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf1.numberView.frame = CGRectMake(0, Kheight, Kwidth, Kheight);
        }];
    };
    [self.view addSubview:_numberView];
    
    //首页导航页面
    navigationView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 40, Kwidth, Kheight)];
    [_mainBackView addSubview:navigationView];
    
    //搜索页面，默认隐藏
    searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 64, Kwidth, Kheight)];
    [self.view addSubview:searchView];

}


- (void)setupData {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *pulseDBName = [userDefaultes objectForKey:@"pulseDBName"];
    if (!pulseDBName) {
        [[InfraredData sharedInfraredData] parserJSON];
        NSString *dbName = [InfraredData sharedInfraredData].dbName;
        [userDefaultes setObject:dbName forKey:@"pulseDBName"];
    }else{
        [InfraredData sharedInfraredData].dbName = pulseDBName;
    }
    
    [self creatProgramData];

    
}

- (IBAction)switchAction:(id)sender {
    NSString *userCode = @"bf00";
    NSString *datacodeValue = @"0d";
    [[WaveService shareInstance] sendSignal:userCode dataCode:datacodeValue];
}
- (IBAction)voiceAction:(id)sender {
    [UIView animateWithDuration:0.1 animations:^{
        _voiceBackView.frame = CGRectMake(0, 421, Kwidth, _voiceBackView.frame.size.height);
    }];
    [_voiceView start];
}

- (IBAction)volumeAction:(id)sender {
   
}
 
- (IBAction)changeChannelAction:(id)sender {
}
- (IBAction)moreAction:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openNumberView {
    [UIView animateWithDuration:1 animations:^{
        _numberView. frame = CGRectMake(0, 0, Kwidth, Kheight);
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.2 animations:^{
        searchView.hidden = NO;
    }];
    return NO;
}

#pragma mark --Voice delegate
- (void)onUpdateVolume:(float)volume {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.progressView setProgress:(volume/100) animated:YES];
    });
}

- (void)onEndOfSpeech {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.1 animations:^{
            weakSelf.voiceBackView.frame = CGRectMake(0, Kheight, Kwidth, _voiceBackView.frame.size.height);
        }];

    });
}

-(void)onBeginningOfSpeech {
    
}

-(void)onCancel {
    
}

//创建频道列表
- (void)creatProgramData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"program" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        NSLog(@"error is %@",err.localizedDescription);
        return;
    }
    
    [UserManager shareInstance].programData = [[NSDictionary alloc] initWithDictionary:dic];


}

@end
