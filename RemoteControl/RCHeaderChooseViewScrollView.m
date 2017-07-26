//
//  RCHeaderChooseViewScrollView.m
//  RemoteControl
//
//  Created by olami on 2017/7/5.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "RCHeaderChooseViewScrollView.h"
#import "Macro.h"

@interface RCHeaderChooseViewScrollView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIButton* selectedBtn;
@property (nonatomic, strong) UIView* sliderView;
@property (nonatomic, strong) NSMutableArray *btnArray;

@end

@implementation RCHeaderChooseViewScrollView{
    UIColor *titleColor;
    UIColor *titleSelectedColor;
    CGFloat titleFontSize;
    NSArray *titleArray;
    CGFloat headerH;
}

- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray=[NSMutableArray array];
    }
    return _btnArray;
}

#pragma mark - UI

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator=NO;
        self.delegate=self;
        //        self.auto
        headerH=self.frame.size.height;
    }
    return self;
}

//移除通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)setUpTitleArray :(NSArray <NSString *> *)array titleColor :(UIColor *)color titleSelectedColor:(UIColor *)selectedColor titleFontSize :(CGFloat)size{
    titleColor=color;
    if (color==nil) {
        titleColor=COLOR(102, 102, 102, 1);
    }
    
    titleSelectedColor=selectedColor;
    if (selectedColor==nil) {
        titleSelectedColor=COLOR(199, 13, 23, 1);
    }
    
    titleFontSize=size;
    if (size==0) {
        titleFontSize=13;
    }
    
    titleArray=array;
    if (array.count!=0) {
        [self setUpUI];
    }
}

//UI
- (void)setUpUI{
    
    if (titleArray.count==0) {
        return;
    }
    
    for (NSInteger i=0; i<titleArray.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [self.btnArray addObject:btn];
        btn.tag=i+100;
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:titleFontSize]];
        
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setTitleColor:titleSelectedColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor clearColor]];
        
        if (i==0) {
            btn.selected=YES;
            self.selectedBtn=btn;
        }
    }
    
    //    滑块
    UIView*sliderView=[[UIView alloc]init];
    [self addSubview:sliderView];
    sliderView.backgroundColor=titleSelectedColor;
    self.sliderView=sliderView;
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:titleFontSize] forKey:NSFontAttributeName];
    CGSize textSize = [titleArray[0] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    self.sliderView.rc_width=textSize.width;
    self.sliderView.rc_height=2;
    self.sliderView.rc_y=headerH-2;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 按钮
    CGFloat btnH=headerH-2;
    CGFloat totalX=25;
    
    for (NSInteger i=0; i<self.btnArray.count; i++) {
        
        CGRect btnRect=[titleArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, btnH) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:titleFontSize],NSFontAttributeName, nil] context:nil];
        
        UIButton *btn=self.btnArray[i];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:titleFontSize]];
        
        btn.rc_size=btnRect.size;
        btn.rc_x=totalX;
        btn.rc_y=1;
        btn.rc_height=btnH;
        totalX=totalX+btnRect.size.width+35;
    }
    
    if (totalX-10<Kwidth) {
        self.contentSize=CGSizeMake(Kwidth, 0);
    }else{
        self.contentSize=CGSizeMake(totalX-10, 0);
    }
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:titleFontSize] forKey:NSFontAttributeName];
    CGSize textSize = [titleArray[self.selectedBtn.tag-100] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.sliderView.rc_width=textSize.width;
    self.sliderView.rc_centerX=self.selectedBtn.rc_centerX;
}

//通知改变字体
- (void)changeFontSize{
    [self layoutSubviews];
}
//按钮点击事件
- (void)btnClick:(UIButton *)btn{
    if (self.btnChooseClickReturn!=nil) {
        self.btnChooseClickReturn(btn.tag-100);
    }
    self.selectedBtn.selected=NO;
    btn.selected=YES;
    self.selectedBtn=btn;
    self.sliderView.rc_width=btn.titleLabel.rc_width;
    [UIView animateWithDuration:0.2 animations:^{
        self.sliderView.rc_centerX=btn.rc_centerX;
    }];
    //    设置scrollview的滑动
    CGFloat offset=btn.center.x-Kwidth*0.5;
    
    if (offset<0) {
        offset=0;
    }
    
    CGFloat maxOffset=self.contentSize.width-Kwidth;
    
    if (offset>maxOffset) {
        offset=maxOffset;
    }
    [self setContentOffset:CGPointMake(offset, 0) animated:YES];
}

-(void)scollToCurrentButtonWithIndex:(NSInteger)index{
    //    NSLog(@"%@",self.subviews);
    UIButton * btn = (UIButton *)[self viewWithTag:index+100];
    self.selectedBtn.selected=NO;
    btn.selected=YES;
    self.selectedBtn=btn;
    self.sliderView.rc_width=btn.titleLabel.rc_width;
    [UIView animateWithDuration:0.2 animations:^{
        self.sliderView.rc_centerX=btn.rc_centerX;
    }];
    //    设置scrollview的滑动
    CGFloat offset=btn.center.x-Kwidth*0.5;
    
    if (offset<0) {
        offset=0;
    }
    
    CGFloat maxOffset=self.contentSize.width-Kwidth;
    
    if (offset>maxOffset) {
        offset=maxOffset;
    }
    [self setContentOffset:CGPointMake(offset, 0) animated:YES];
    
}

@end


@implementation UIView (JZLViewFrame)

- (UIViewController *)rc_currentVc{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

+ (instancetype)rc_viewLoadWithXib{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (CGFloat)rc_x{
    return self.frame.origin.x;
}

- (void)setRc_x:(CGFloat)rc_x{
    CGRect frame=self.frame;
    frame.origin.x=rc_x;
    self.frame=frame;
}

- (CGFloat)rc_y{
    return self.frame.origin.y;
}

- (void)setRc_y:(CGFloat)rc_y{
    CGRect frame=self.frame;
    frame.origin.y=rc_y;
    self.frame=frame;
}

- (CGFloat)rc_width{
    return self.frame.size.width;
}

- (void)setRc_width:(CGFloat)rc_width{
    CGRect frame=self.frame;
    frame.size.width=rc_width;
    self.frame=frame;
}

- (CGFloat)rc_height{
    return self.frame.size.height;
}

- (void)setRc_height:(CGFloat)rc_height{
    CGRect frame=self.frame;
    frame.size.height=rc_height;
    self.frame=frame;
}

- (CGFloat)rc_right{
    return CGRectGetMaxX(self.frame);
}

- (void)setRc_right:(CGFloat)rc_right{
    CGRect frame=self.frame;
    frame.origin.x=rc_right-frame.size.width;
    self.frame=frame;
}

- (CGFloat)rc_bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setRc_bottom:(CGFloat)rc_bottom{
    CGRect frame=self.frame;
    frame.origin.y=rc_bottom-frame.size.height;
    self.frame=frame;
}

- (CGFloat)rc_centerX{
    return self.center.x;
}

- (void)setRc_centerX:(CGFloat)rc_centerX{
    CGPoint center=self.center;
    center.x=rc_centerX;
    self.center=center;
}

- (CGFloat)rc_centerY{
    return self.center.y;
}

- (void)setRc_centerY:(CGFloat)rc_centerY{
    CGPoint center=self.center;
    center.y=rc_centerY;
    self.center=center;
}

- (CGSize)rc_size{
    return self.frame.size;
}

- (void)setRc_size:(CGSize)rc_size{
    CGRect frame=self.frame;
    frame.size=rc_size;
    self.frame=frame;
}


@end
