//
//  TNDrawLineVC.m
//  TNDemoKit
//
//  Created by 罗义德 on 16/1/16.
//  Copyright © 2016年 lyd. All rights reserved.
//

#import "TNDrawLineVC.h"
#import "TNDrawingBoard.h"
#import "TNAnimatedMenu.h"

@implementation TNDrawLineVC
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
    
    //画板1
    TNDrawingBoard *drawBoard = [[TNDrawingBoard alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.view.frame)-20, (CGRectGetHeight(self.view.frame)-20-64)/2)];
    drawBoard.layer.borderColor = [UIColor redColor].CGColor;
    drawBoard.layer.borderWidth = 1.0;
    
    [drawBoard setBrushColor:[UIColor blackColor]];
    [self.view addSubview:drawBoard];
    
    //画板2
    drawBoard = [[TNDrawingBoard alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(drawBoard.frame), CGRectGetWidth(self.view.frame)-20, (CGRectGetHeight(self.view.frame)-20-64)/2)];
    drawBoard.layer.borderColor = [UIColor redColor].CGColor;
    drawBoard.layer.borderWidth = 1.0;
    drawBoard.isDrawMainLayer = YES;
    
    [drawBoard setBrushColor:[UIColor blackColor]];
    [self.view addSubview:drawBoard];
    
}

//初始化数据
- (void)configData {
    
}

#pragma mark 响应事件

#pragma mark 网络相关

#pragma mark protocol method

#pragma mark publick method
@end
