//
//  TNSingleLandscape1VC.m
//  TNDemoKit
//
//  Created by 罗义德 on 16/1/20.
//  Copyright © 2016年 lyd. All rights reserved.
//

#import "TNSingleLandscape1VC.h"

@implementation TNSingleLandscape1VC
#pragma mark system method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)dealloc {
    
}

#pragma mark private method
//创建UI
- (void)setupUI {

}

//初始化数据
- (void)configData {
    
}

#pragma mark 响应事件
//返回上一层
- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 网络相关

#pragma mark protocol method

#pragma mark publick method
@end
