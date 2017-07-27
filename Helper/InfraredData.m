//
//  InfraredData.m
//  RemoteControl
//
//  Created by olami on 2017/7/3.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "InfraredData.h"
#import "FMDBHelp.h"

#define TABLENAME @"pulseTable"


@interface InfraredData(){
   
}

@end

@implementation InfraredData

#pragma mark - 单例
+ (InfraredData*)sharedInfraredData {
    static InfraredData *help = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        help = [[InfraredData alloc] init];
    });
    return help;
}

- (void)setDbName:(NSString *)dbName{
    [[FMDBHelp sharedFMDBHelp] createDBWithName:dbName];
}


- (void)createTable {
    [[FMDBHelp sharedFMDBHelp] createDBWithName:@"pulseDBName"];
    NSString *createTableSql =
    [NSString stringWithFormat:@"create table if not exists %@('pulseID' text primary key not null,'chineseName' text,'userCode' text,'deviceName' text,'pulseData' text,'datacodeValue' text)",TABLENAME];
    
    BOOL isCreate =  [[FMDBHelp sharedFMDBHelp] notResultSetWithSql:createTableSql];
    if (isCreate) {
        NSLog(@"create pulseTable done!");
    }else{
        NSLog(@"create pulseTable failure!");
    }
}

- (void)parserJSON:(NSData*)jsonData{
    [self createTable];
    [self generateData:jsonData];
}



-(void)generateData:(NSData*)data {
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingMutableContainers
                                                         error:&err];
    if (err) {
        NSLog(@"error is %@",err.localizedDescription);
        return;
    }
    
    NSString *userCode = [dic objectForKey:@"usercode"];
    NSString *deviecName = [dic objectForKey:@"devicename"];
    NSArray *dataCodeArry = [dic objectForKey:@"datacode"];
    for (int i=0; i<dataCodeArry.count; i++) {
        NSDictionary *dicData = dataCodeArry[i];
        NSString *chineseName = [dicData objectForKey:@"chinesename"];
        NSString *idNum = [dicData objectForKey:@"id"];
        NSString *dataCodeValue = [dicData objectForKey:@"datacodevalue"];
        NSString *pulseData = [dicData objectForKey:@"pulsedata"];
        
        NSString *insertSql = [NSString stringWithFormat:@"insert into '%@'(pulseID,chineseName,userCode,deviceName,pulseData,datacodeValue) values ('%@','%@','%@','%@','%@','%@')",TABLENAME,idNum,chineseName,userCode,deviecName,pulseData,dataCodeValue];
        [[FMDBHelp sharedFMDBHelp] notResultSetWithSql:insertSql];

    }
    
    
}




- (NSString *)searchPulseData:(NSString*)pulseID {
    NSString *searchSql = [NSString stringWithFormat:@"select pulseData from pulseTable where pulseID = '%@'",pulseID];
    NSArray *arry = [[FMDBHelp sharedFMDBHelp] qureyWithSql:searchSql];
    NSDictionary *dic = arry[0];
    NSString *result = [dic objectForKey:@"pulseData"];
    //NSLog(@"result is %@",result);
    return result;
}

- (NSDictionary *)searchData:(NSString*)index {
    NSString *searchSql = [NSString stringWithFormat:@"select usercode,datacodevalue from pulseTable where pulseID = '%@'",index];
    NSArray *arry = [[FMDBHelp sharedFMDBHelp] qureyWithSql:searchSql];
    NSDictionary *dic = arry[0];
    NSLog(@"result is %@",dic);
    return dic;
}
@end
