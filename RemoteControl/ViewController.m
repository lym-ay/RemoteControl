//
//  ViewController.m
//  RemoteControl
//
//  Created by olami on 2017/6/30.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "ViewController.h"
#import "InfraredData.h"
#import "Macro.h"
#import "SearchView.h"
#import "NavigationView.h"
#import "ProgramSearchView.h"



@interface ViewController (){
    SearchView          *searchView;
    NavigationView      *navigationView;
    ProgramSearchView   *programSearchView;
}


@end

@implementation ViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    navigationView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 64, Kwidth, Kheight-64)];
    [self.view addSubview:navigationView];
    
    searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, Kwidth, Kheight)];
    searchView.hidden = YES;
    [self.view addSubview:searchView];
    
    programSearchView = [[ProgramSearchView alloc] initWithFrame:CGRectMake(0, 32, Kwidth, Kheight-64)];
    [self.view addSubview:programSearchView];
 
}
- (IBAction)buttonAction:(id)sender {
    searchView.hidden = NO;
}

- (void)initData {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *pulseDBName = [userDefaultes objectForKey:@"pulseDBName"];
    if (!pulseDBName) {
        [[InfraredData sharedInfraredData] parserJSON];
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

 

@end
