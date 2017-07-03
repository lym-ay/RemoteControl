//
//  InfraredData.h
//  RemoteControl
//
//  Created by olami on 2017/7/3.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfraredData : NSObject
@property (nonatomic, copy) NSString *buttonID;//按钮对应的ID
@property (nonatomic, copy) NSString *buttonEnglishName;//按钮对应功能的英文名称
@property (nonatomic, copy) NSString *buttonChineseName;//按钮对应功能的中文名称
@property (nonatomic, copy) NSArray  *buttonPlusData;//按钮对应的红外线码
@end
