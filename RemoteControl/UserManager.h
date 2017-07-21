//
//  UserManager.h
//  RemoteControl
//
//  Created by olami on 2017/7/19.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject
@property (nonatomic, copy) NSArray  *companyNameArry;//用来保存当前城市的运营商的名称
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *companyName;//当前选择的运营商的名称
+(UserManager *)shareInstance;
@end
