//
//  UserManager.m
//  RemoteControl
//
//  Created by olami on 2017/7/19.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

//这个是一个共享类，用来保存各个模块之间共享的数据
#import "UserManager.h"

@implementation UserManager
+ (UserManager *)shareInstance {
    static UserManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserManager alloc] init];
    });
    
    return instance;
}

//- (id)init {
//    if (self = [super init]) {
//        _companyNameArry = [[NSArray alloc] init];
//    }
//    return  self;
//}

@end
