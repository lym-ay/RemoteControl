//
//  ScheduleMode.h
//  RemoteControl
//
//  Created by olami on 2017/7/10.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgramData : NSObject
@property (nonatomic ,strong) NSString                   *channel_title;
@property (nonatomic ,strong) NSString                   *program_type_id;
@property (nonatomic ,strong) NSString                   *end_time;
@property (nonatomic ,strong) NSString                   *program_title;
@property (nonatomic ,strong) NSString                   *program_subtype_id;
@property (nonatomic ,strong) NSString                   *start_time;
@property (nonatomic ,strong) NSString                   *ctrl_number;
@property (nonatomic ,strong) NSString                   *epiosode_number;
@property (nonatomic ,strong) NSString                   *program_id;
@property (nonatomic ,strong) NSString                   *channel_id;
@property (nonatomic ,strong) NSString                   *weekDay;
@property (nonatomic ,assign) BOOL                       isPlaying;//表示这个节目当前是否正在播放

@end

@interface ScheduleMode : NSObject
+(ScheduleMode*)shareInstance;
-(void)initWithData:(NSDictionary *)dic;
- (NSArray*)propertyKeys:(ProgramData*)data;
- (void)reflectDataFromOtherObject:(ProgramData*)data dicData:(NSDictionary*)dic;
@property (nonatomic,strong) NSMutableArray         *dataArrys;//保存所有的data值
@end
