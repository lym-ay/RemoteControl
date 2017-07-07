//
//  RCHeaderChooseViewScrollView.h
//  RemoteControl
//
//  Created by olami on 2017/7/5.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^btnChooseClickBlock)(NSInteger x);

@interface RCHeaderChooseViewScrollView : UIScrollView

@property (nonatomic, copy)btnChooseClickBlock btnChooseClickReturn;

- (void)setUpTitleArray :(NSArray <NSString *> *)array titleColor :(UIColor *)color titleSelectedColor:(UIColor *)selectedColor titleFontSize :(CGFloat)size;
//联动方法
-(void)scollToCurrentButtonWithIndex:(NSInteger)index;

@end


@interface UIView (RCViewFrame)

@property(nonatomic,assign)CGFloat rc_height;

@property(nonatomic,assign)CGFloat rc_width;

@property(nonatomic,assign)CGFloat rc_x;

@property(nonatomic,assign)CGFloat rc_y;

@property(nonatomic,assign)CGFloat rc_right;

@property(nonatomic,assign)CGFloat rc_bottom;

@property(nonatomic,assign)CGFloat rc_centerX;

@property(nonatomic,assign)CGFloat rc_centerY;

@property(nonatomic,assign)CGSize rc_size;

@end
