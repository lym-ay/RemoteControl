//
//  ViewController.m
//  RemoteControl
//
//  Created by olami on 2017/6/30.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "ViewController.h"
#import "InfraredData.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initData];
 
}

- (void)initData {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *pulseDBName = [userDefaultes objectForKey:@"pulseDBName"];
    if (!pulseDBName) {
        [[InfraredData sharedInfraredData] parserXML];
        NSString *dbName = [InfraredData sharedInfraredData].dbName;
        [userDefaultes setObject:dbName forKey:@"pulseDBName"];
    }else{
        [InfraredData sharedInfraredData].dbName = pulseDBName;
    }
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(id)sender {
    _textView.text = [[InfraredData sharedInfraredData] searchPulseData:@"1"];
     
   
    
}

@end
