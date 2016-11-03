//
//  TNRootViewController.m
//  SingleMentoring
//
//  Created by 罗义德 on 15/12/9.
//  Copyright © 2015年 lyd. All rights reserved.
//

#import "TNRootViewController.h"

@interface TNRootViewController ()<UIGestureRecognizerDelegate>
/** viewModel数组,懒加载方式实例化 */
@property(nonatomic, strong, readonly)NSMutableArray *viewModels;

@end

@implementation TNRootViewController

#pragma mark system method
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        //去掉边缘化 适配
        self.edgesForExtendedLayout = UIRectEdgeNone;
        //去掉scrollView自动偏移
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //开启侧滑功能
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && self.navigationController) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait ;
}

- (BOOL)shouldAutorotate {
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

#pragma mark public method
/** 返回上级页面 */
- (void)goBackVC {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
