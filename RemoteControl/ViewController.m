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



@interface ViewController ()<UITextFieldDelegate>{
    SearchView          *searchView;
    NavigationView      *navigationView;
    ProgramSearchView   *programSearchView;
    
}
@property (weak, nonatomic) IBOutlet UIView *searchBackView;//保存搜索框的view
@property (nonatomic, strong) SearchTextField *searchField;
@property (nonatomic, strong) VoiceView       *voiceView;
@property (nonatomic, strong) NumberView      *numberView;


@end

@implementation ViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
//    navigationView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 64, Kwidth, Kheight-64)];
//    [self.view addSubview:navigationView];
    
//    searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, Kwidth, Kheight)];
//    searchView.hidden = YES;
//    [self.view addSubview:searchView];
//    
//    programSearchView = [[ProgramSearchView alloc] initWithFrame:CGRectMake(0, 32, Kwidth, Kheight-64)];
//    [self.view addSubview:programSearchView];
 
}
- (IBAction)buttonAction:(id)sender {
//    searchView.hidden = NO;
}



- (void)setupUI {
    _searchField = [[SearchTextField alloc] init];
    _searchField.delegate = self;
    _searchField.layer.borderWidth =1;
    _searchField.layer.borderColor = COLOR(204, 204, 204, 204).CGColor;
    _searchField.layer.cornerRadius = 5;
    _searchField.layer.masksToBounds = YES;
    [_searchBackView addSubview:_searchField];
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
 
    
    //声音界面
    _voiceView = [[VoiceView alloc] initWithFrame:CGRectMake(0, Kheight, Kwidth, Kheight)];
    __weak typeof(self) weakSelf = self;
    _voiceView.block= ^{
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.voiceView.frame = CGRectMake(0, Kheight, Kwidth, Kheight);
        }];
    };
    [self.view addSubview:_voiceView];
    
    
    //数字键盘界面
    _numberView = [[NumberView alloc] initWithFrame:CGRectMake(0, Kheight, Kwidth, Kheight)];
    __weak typeof(self) weakSelf1 = self;
    _numberView.block= ^{
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf1.numberView.frame = CGRectMake(0, Kheight, Kwidth, Kheight);
        }];
    };
    [self.view addSubview:_numberView];

}


- (void)setupData {
    
}

- (IBAction)switchAction:(id)sender {
}

- (IBAction)volumeAction:(id)sender {
}
- (IBAction)speakAction:(id)sender {
    [UIView animateWithDuration:1 animations:^{
        _voiceView.frame = CGRectMake(0, 0, Kwidth, Kheight);
    }];

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
    NSLog(@"test");
    return NO;
}

@end
