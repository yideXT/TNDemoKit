//
//  MainViewController.m
//  TNDemoKit
//
//  Created by 罗义德 on 16/1/16.
//  Copyright © 2016年 lyd. All rights reserved.
//

#import "MainViewController.h"
#import "MainModel.h"
#import "TNDrawLineVC.h"
#import "TNSingleLandscapeMainVC.h"

@implementation MainViewController {
    NSMutableArray *_dataArray;
}

#pragma mark system method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait ;
}

- (BOOL)shouldAutorotate {
    return YES;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)dealloc {
    
}

#pragma mark private method
//创建UI
- (void)setupUI {
    
    self.title = @"DemoKit";
    
    _dataArray = [[NSMutableArray alloc] init];
    
    MainModel *model = [[MainModel alloc] initWithTitle:@"画板demo" VcClassStr:@"TNDrawLineVC"];
    model.isStoryboardVC = NO;
    [_dataArray addObject:model];
    
    model = [[MainModel alloc] initWithTitle:@"强制横屏demo" VcClassStr:@"TNSingleLandscapeMainVC"];
    model.isPush = NO;
    [_dataArray addObject:model];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView reloadData];
}

//初始化数据
- (void)configData {
    
}

#pragma mark 响应事件

#pragma mark 网络相关

#pragma mark protocol method
#pragma mark tableView协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MainCell"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    MainModel *model = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.itemTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc]init];
    backBarButtonItem.title =@"";
    self.navigationItem.backBarButtonItem = backBarButtonItem;
    
    MainModel *model = [_dataArray objectAtIndex:indexPath.row];
    
    //跳转页面
    
    UIViewController *viewController;
    if (model.isStoryboardVC) {
        viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:model.itemVCclass];
    }else {
        viewController = [[NSClassFromString(model.itemVCclass) alloc] init];
    }
    
    if (model.isPush) {
        viewController.navigationItem.title = model.itemTitle;
        [self.navigationController pushViewController:viewController animated:YES];
    }else {
        [self presentViewController:viewController animated:NO completion:nil];
    }
    
}


#pragma mark publick method
@end
