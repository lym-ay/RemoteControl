//
//  SearchView.h
//  RemoteControl
//
//  Created by olami on 2017/7/7.
//  Copyright © 2017年 VIA Technologies, Inc. & OLAMI Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchTableViewDelegate <NSObject>

-(void)searchData:(NSString*) name;

@end

@interface SearchTableView : UIView
@property (nonatomic, strong) id<SearchTableViewDelegate> delegate;
@end
