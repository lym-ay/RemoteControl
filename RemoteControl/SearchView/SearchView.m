//
//  SearchView.m
//  RemoteControl
//
//  Created by olami on 2017/7/25.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "SearchView.h"
#import "Macro.h"
#import "SearchTextField.h"
#import "Masonry.h"
#import "SearchTableView.h"
#import "ProgramSearchView.h"

@interface SearchView()<UITextFieldDelegate,SearchTableViewDelegate>
@property (nonatomic, strong) UIView *searchFieldBackView;
@property (nonatomic, strong) SearchTextField *searchField;
@property (nonatomic, strong) SearchTableView *searchTableView;
@property (nonatomic, strong) ProgramSearchView *programSearchView;
@end

@implementation SearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupData];
        [self setupView];
    }
    
    return self;
}


- (void)setupData {
    
}


-(void)setupView {
    self.backgroundColor = [UIColor whiteColor];
    
    //搜索textField背景栏
    _searchFieldBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Kwidth, 40)];
    _searchFieldBackView.backgroundColor = COLOR(236, 236, 236, 1);
    [self addSubview:_searchFieldBackView];
    
    //搜索框
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
        make.edges.mas_offset(UIEdgeInsetsMake(6, 15, 6, 50));
    }];
    
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_searchFieldBackView addSubview:cancelButton];
    [cancelButton addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
        make.top.equalTo(_searchField.mas_top).offset(5);
        make.left.equalTo(_searchField.mas_right).offset(5);
    }];
 
    //搜索页面
    _searchTableView = [[SearchTableView alloc] initWithFrame:CGRectMake(0, 40, Kwidth, Kheight)];
    _searchTableView.delegate = self;
    [self addSubview:_searchTableView];
    
    //显示搜索结果的页面
    _programSearchView = [[ProgramSearchView alloc] initWithFrame:CGRectMake(0, 40, Kwidth, Kheight)];
    _programSearchView.hidden = YES;
    [self addSubview:_programSearchView];
}

- (void)openNumberView {
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
   return YES;
}

- (void)hideView {
    _programSearchView.hidden = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.hidden = YES;
        
    }];
}

-(void)searchData:(NSString *)name {
    _searchField.text = name;
    [UIView animateWithDuration:0.2 animations:^{
        _programSearchView.hidden = NO;
    }];
}

@end
