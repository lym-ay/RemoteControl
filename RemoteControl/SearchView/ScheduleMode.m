//
//  ScheduleMode.m
//  RemoteControl
//
//  Created by olami on 2017/7/10.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "ScheduleMode.h"
#import <objc/message.h>

@implementation ProgramData



@end

@interface ScheduleMode()
@property (nonatomic,strong) NSDictionary   *dicData;
@end

@implementation ScheduleMode

+(ScheduleMode*)shareInstance {
    static ScheduleMode *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ScheduleMode alloc] init];
    });
    
    return instance;
}

-(void)initWithData:(NSDictionary *)dic{
    _dataArrys = [[NSMutableArray alloc] init];
    _dicData = dic;
    [self setDatas];
}

-(void)setDatas{
    NSArray *arry = [_dicData objectForKey:@"data_obj"];
    
    for (int i=0; i<arry.count; i++) {
        ProgramData *data = [[ProgramData alloc] init];
        NSDictionary    *dataDic = [arry objectAtIndex:i];
        [self propertyKeys:data];
        [self reflectDataFromOtherObject:data dicData:dataDic];
        [_dataArrys addObject:data];
    }
}



#pragma mark --利用反射机制获得所有属性的值
- (NSArray*)propertyKeys:(ProgramData*)data{
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([data class], &outCount);
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
        //NSLog(@"propertyName is %@",propertyName);
    }
    free(properties);
    return keys;
}

//读取保存的属性的值
- (void)reflectDataFromOtherObject:(ProgramData*)data dicData:(NSDictionary*)dic{
    for(NSString *key in [self propertyKeys:data]){
        id propertyValue = [dic valueForKey:key];
        if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
            [data setValue:propertyValue forKey:key];
            
            //NSLog(@"key is %@,propertyName is %@",key,propertyValue);
        }
    }
    
    
}



@end
