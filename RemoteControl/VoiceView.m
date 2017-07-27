//
//  VoiceView.m
//  RemoteControl
//
//  Created by olami on 2017/7/20.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "VoiceView.h"
#import "Masonry.h"
#import "Macro.h"
#import "OlamiRecognizer.h"
#import "WaveService.h"
#import "FMDBHelp.h"
#import "InfraredData.h"
#import "UserManager.h"

#define OLACUSID   @"341764bb-3dc9-4e88-8f66-9f7434e867f2"

@interface VoiceView () <OlamiRecognizerDelegate> {
    OlamiRecognizer *olamiRecognizer;
}

@property (strong, nonatomic) NSMutableArray *slotValue;//保存slot的值
@property (strong, nonatomic) NSString *api;

@end

@implementation VoiceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupData];
        [self setupUI];
    }
    
    return self;
}




- (void)setupData {
    olamiRecognizer= [[OlamiRecognizer alloc] init];
    olamiRecognizer.delegate = self;
    [olamiRecognizer setAuthorization:@"3142ca73156d4b9cbf2f9a9966b1ff8c"
                                  api:@"asr" appSecret:@"a46ad409861c403b89809499d44053b7" cusid:OLACUSID];
    
    [olamiRecognizer setLocalization:LANGUAGE_SIMPLIFIED_CHINESE];//设置语系，这个必须在录音使用之前初始化
    
    
    
    _slotValue = [[NSMutableArray alloc] init];
}


- (void)setupUI {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, Kwidth, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = COLOR(255, 255, 255, 1);
    label.font = [UIFont fontWithName:FONTFAMILY size:18];
    label.text = @"说出你想要搜索的频道或节目";
    [self addSubview:label];
    
    
}


- (void)backAction:(UIButton *)button {
    self.block();
}

- (void)okAction:(UIButton *)button {
    
}

- (void)start {
    [olamiRecognizer start];
}

- (void)stop {
    if (olamiRecognizer.isRecording) {
        [olamiRecognizer stop];
    }
}


- (void)onResult:(NSData *)result {
    NSError *error;
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if (error) {
        NSLog(@"error is %@",error.localizedDescription);
    }else{
        NSString *jsonStr=[[NSString alloc]initWithData:result
                                               encoding:NSUTF8StringEncoding];
        NSLog(@"jsonStr is %@",jsonStr);
        NSString *ok = [dic objectForKey:@"status"];
        if ([ok isEqualToString:@"ok"]) {
            NSDictionary *dicData = [dic objectForKey:@"data"];
            NSDictionary *asr = [dicData objectForKey:@"asr"];
            if (asr) {//如果asr不为空，说明目前是语音输入
                [weakSelf processASR:asr];
            }
            NSDictionary *nli = [[dicData objectForKey:@"nli"] objectAtIndex:0];
            NSDictionary *desc = [nli objectForKey:@"desc_obj"];
            int status = [[desc objectForKey:@"status"] intValue];
            if (status != 0) {// 0 说明状态正常,非零为状态不正常
                NSString *result  = [desc objectForKey:@"result"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
                
            }else{
                NSDictionary *semantic = [[nli objectForKey:@"semantic"]
                                          objectAtIndex:0];
                [weakSelf processSemantic:semantic];
                
            }
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        }
    }
    
    
    
}

- (void)onBeginningOfSpeech {
    [self.delegate onBeginningOfSpeech];
}

- (void)onEndOfSpeech {
    [self.delegate onEndOfSpeech];
    
}


- (void)onError:(NSError *)error {
    
    
    if (error) {
        NSLog(@"error is %@",error.localizedDescription);
    }
    
}

-(void)onCancel {
    [self.delegate onCancel];
}


#pragma mark -- 处理语音和语义的结果
- (void)processModify:(NSString*) str {
    if ([str isEqualToString:@"query_parade_name"]
        || [str isEqualToString:@"watch_channel"]
        || [str isEqualToString:@"needmore"]
        || [str isEqualToString:@"needmore_ask"]) {//查看那个频道
        NSString *channelName = _slotValue[0];
        if (channelName) {
            NSString *str = [[UserManager shareInstance].programData objectForKey:channelName];
            int num = [str intValue];
             [self sendNum:num];
        }
       
       
    }else if ([str isEqualToString:@"rules"]){
        
        
    }else if ([str isEqualToString:@""]){
        
        
    }else if ([str isEqualToString:@"watch_a_program"]){//查看具体的节目
        
    }else if ([str isEqualToString:@"tv_close"] ||
              [str isEqualToString:@"tv_open"]){//打开和关闭电视
        NSString *userCode = @"bf00";
        NSString *datacodeValue = @"0d";
        [[WaveService shareInstance] sendSignal:userCode dataCode:datacodeValue];
    }
    
}

//处理ASR节点
- (void)processASR:(NSDictionary*)asrDic {
    NSString *result  = [asrDic objectForKey:@"result"];
    if (result.length == 0) { //如果结果为空，则弹出警告框
        
    }else{
        
    }
    
}

//处理Semantic节点
- (void)processSemantic:(NSDictionary*)semanticDic {
    NSArray *slot = [semanticDic objectForKey:@"slots"];
    [_slotValue removeAllObjects];
    if (slot.count != 0) {
        for (NSDictionary *dic in slot) {
            NSString* val = [dic objectForKey:@"value"];
            [_slotValue addObject:val];
        }
        
    }
    
    NSArray *modify = [semanticDic objectForKey:@"modifier"];
    if (modify.count != 0) {
        for (NSString *s in modify) {
            [self processModify:s];
            
        }
        
    }
    
}

- (void)onUpdateVolume:(float)volume {
    [self.delegate onUpdateVolume:volume];
}

- (void)sendNum:(NSInteger)okNum {
    NSMutableArray *arry = [[NSMutableArray alloc] init];
    
    while (okNum) {
        int num = okNum%10;
        [arry addObject:[NSString stringWithFormat:@"%d",num]];
        okNum = okNum/10;
    }
    
    
    NSString *str0 = arry[arry.count-1];
    NSDictionary *dic = [[InfraredData sharedInfraredData] searchData:str0];
    NSLog(@"str0 is %@",str0);
    NSSLog(@"dic is %@",dic);
    if (dic) {
        NSString *userCode = [dic objectForKey:@"userCode"];
        NSString *datacodeValue = [dic objectForKey:@"datacodeValue"];
        [[WaveService shareInstance] sendSignal:userCode dataCode:datacodeValue];
       
    }
    
    
    for (int i=arry.count-2; i>=0; i--) {
        NSString *str = arry[i];
        //如果数字大于2，则延时1秒钟单独发送各个数字
        //[self performSelector:@selector(sendSignal:) withObject:str afterDelay:1];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"str is %@",str);
            NSDictionary *dic = [[InfraredData sharedInfraredData] searchData:str];
            NSSLog(@"dic is %@",dic);
            if (dic) {
                NSString *userCode = [dic objectForKey:@"userCode"];
                NSString *datacodeValue = [dic objectForKey:@"datacodeValue"];
                [[WaveService shareInstance] sendSignal:userCode dataCode:datacodeValue];
                
                
            }

        });
    }

}





@end
