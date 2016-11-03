//
//  TNNavigationController.m
//  TNDemoKit
//
//  Created by 罗义德 on 16/1/20.
//  Copyright © 2016年 lyd. All rights reserved.
//

#import "TNNavigationController.h"

@implementation TNNavigationController
#pragma mark system method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark 横屏设置
-(BOOL)shouldAutorotate {
    return [self.viewControllers.lastObject shouldAutorotate];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
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

#pragma mark 网络相关

#pragma mark protocol method

#pragma mark publick method
@end
