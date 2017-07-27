//
//  SettingViewController.m
//  RemoteControl
//
//  Created by olami on 2017/7/10.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *operatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutMeLabel;

@end

 
@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _operatorLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOperatorVC)];
    [_operatorLabel addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aboutMe)];
    [_operatorLabel addGestureRecognizer:tapGesture1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

 
- (void)showOperatorVC {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* mainVC =[mainStoryBoard instantiateViewControllerWithIdentifier:@"SelectOperatorSID"];
    [self presentViewController:mainVC animated:YES completion:nil];

}

- (void)aboutMe {
    
}
 

@end
