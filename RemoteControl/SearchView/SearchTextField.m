//
//  SearchTextField.m
//  RemoteControl
//
//  Created by olami on 2017/7/20.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "SearchTextField.h"

@implementation SearchTextField

 
//重写左视图的位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect SearchRect = [super leftViewRectForBounds:bounds];
    SearchRect.origin.x +=10;
    
    return SearchRect;
}

//重新右视图的位置
- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect SearchRect = [super rightViewRectForBounds:bounds];
    SearchRect.origin.x -=10;
    
    return SearchRect;
}
//重写占位符的x值
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
    placeholderRect.origin.x +=1;
    return placeholderRect;
}
//重写文字输入时的x值
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect editingRect = [super editingRectForBounds:bounds];
    editingRect.origin.x +=10;
    editingRect.size.width -=12;
    return editingRect;
}
//  重写文字显示时的X值
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect textRect = [super editingRectForBounds:bounds];
    textRect.origin.x += 10;
    
    return textRect;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
