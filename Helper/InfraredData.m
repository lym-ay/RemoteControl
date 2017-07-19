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
    [[FMDBHelp sharedFMDBHelp] createDBWithName:@"pulseData"];
    NSString *createTableSql =
    [NSString stringWithFormat:@"create table if not exists %@('pulseID' text primary key not null,'chineseName' text,'userCode' text,'deviceName' text,'pulseData' text,'datacodeValue' text)",TABLENAME];
    
    BOOL isCreate =  [[FMDBHelp sharedFMDBHelp] notResultSetWithSql:createTableSql];
    if (isCreate) {
        NSLog(@"create pulseTable done!");
    }else{
        NSLog(@"create pulseTable failure!");
    }
}

- (void)parserJSON {
    [self createTable];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    [self generateData:data];
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

//- (void)parserXML {
//    [self createTable];
//    NSString *fileXML = [[NSBundle mainBundle] pathForResource:@"key" ofType:@"xml"];
//    NSData *data = [NSData dataWithContentsOfFile:fileXML];
//    [self XMLGDataXMLNodeWithKeyData:data];
//    
//    NSString *fileXML1 = [[NSBundle mainBundle] pathForResource:@"plusData" ofType:@"xml"];
//    NSData *data1 = [NSData dataWithContentsOfFile:fileXML1];
//    [self XMLGDataXMLNodeWithPulseData:data1];
//
//}



////解析遥控器按键对应的信息
//-(void)XMLGDataXMLNodeWithKeyData:(NSData *)data{
//    //1.加载XML数据
//    GDataXMLDocument *XMLDocument = [[GDataXMLDocument alloc] initWithData:data error:nil];
//    //2.拿到XML文件中根元素下需要解析的子元素数组
//    NSArray *elements = [XMLDocument.rootElement elementsForName:@"key"];
//    //3.对子元素数组中所有数据进行解析
//    [elements enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        GDataXMLElement *XMLElement = (GDataXMLElement *)obj;
//        
//        NSArray *children = XMLElement.children;
//        //id
//        GDataXMLNode *node0 = children[0];
//        
//        //english name
//        GDataXMLNode *node1 = children[1];
// 
//        //chinese name
//        GDataXMLNode *node2 = children[2];
// 
//        
//        NSString *insertSql = [NSString stringWithFormat:@"insert into '%@'(pulseID,englishName,chineseName) values ('%@','%@','%@')",TABLENAME,node0.stringValue,node1.stringValue,node2.stringValue];
//        [[FMDBHelp sharedFMDBHelp] notResultSetWithSql:insertSql];
//        
//        
//    }];
//    
//}
//
//
////解析红外线码
//-(void)XMLGDataXMLNodeWithPulseData:(NSData *)data{
//    //1.加载XML数据
//    GDataXMLDocument *XMLDocument = [[GDataXMLDocument alloc] initWithData:data error:nil];
//    //2.拿到XML文件中根元素下需要解析的子元素数组
//    NSArray *elements = [XMLDocument.rootElement elementsForName:@"remote_controller"];
//    //3.对子元素数组中所有数据进行解析
//    [elements enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        GDataXMLElement *XMLElement = (GDataXMLElement *)obj;
//        //remote_controller的孩子
//        NSArray *children = XMLElement.children;
//        
//        //keys的信息  //keys里面63个名字为key的孩子 key有三个孩子:id,pulse,exts
//        GDataXMLNode *nodeKeys = children[4];
//        NSArray *keysChildren = nodeKeys.children;
//        
//        for (int i=0; i<keysChildren.count; i++) {
//           
//            GDataXMLNode *nodeKey = keysChildren[i];
//            NSArray *keyChildren = nodeKey.children;
//            
//            //id
//            GDataXMLNode *node0 = keyChildren[0];
//            
//            
//            //pulse
//            GDataXMLNode *node1 = keyChildren[1];
//            
//            NSString *updateSql = [NSString stringWithFormat:@"update '%@' set pulseData = '%@' where pulseID = '%@' ",TABLENAME,node1.stringValue,node0.stringValue];
//            [[FMDBHelp sharedFMDBHelp] notResultSetWithSql:updateSql];    
//
//        }
//        
//        
//    }];
//    
//}


- (NSString *)searchPulseData:(NSString*)pulseID {
    NSString *searchSql = [NSString stringWithFormat:@"select pulseData from pulseTable where pulseID = '%@'",pulseID];
    NSArray *arry = [[FMDBHelp sharedFMDBHelp] qureyWithSql:searchSql];
    NSDictionary *dic = arry[0];
    NSString *result = [dic objectForKey:@"pulseData"];
    NSLog(@"result is %@",result);
    return result;
}


@end
