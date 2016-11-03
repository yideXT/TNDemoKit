//
//  TNSingleLandscapeMainVC.m
//  TNDemoKit
//
//  Created by 罗义德 on 16/1/20.
//  Copyright © 2016年 lyd. All rights reserved.
//

#import "TNSingleLandscapeMainVC.h"
#import "TNSingleLandscape1VC.h"
#import "AppDelegate.h"

@implementation TNSingleLandscapeMainVC
#pragma mark system method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark 自动横屏设置
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)viewWillDisappear:(BOOL)animated {
    //orientation
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
//    }
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
//返回上一页
- (IBAction)goBack {
    [self goBackVC];
}

//跳转下一页
- (IBAction)goTo {
    TNSingleLandscape1VC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"TNSingleLandscape1VC"];
    [self presentViewController:vc animated:YES completion:nil];
}

//弹出警告框
- (IBAction)popAlertController {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"测试强制横屏" message:@"前方高能，请谨慎!" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark 网络相关

#pragma mark protocol method

#pragma mark publick method
@end
