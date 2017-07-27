//
//  InfraredData.h
//  RemoteControl
//
//  Created by olami on 2017/7/3.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfraredData : NSObject
+ (InfraredData*)sharedInfraredData;
@property (nonatomic,copy) NSString *dbName;
- (void)parserJSON:(NSData*)jsonData;
- (NSString *)searchPulseData:(NSString*)pulseID;
- (NSDictionary *)searchData:(NSString*)index;
@end


