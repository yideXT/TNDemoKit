//
//  MainModel.h
//  TNDemoKit
//
//  Created by 罗义德 on 16/1/16.
//  Copyright © 2016年 lyd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject
- (instancetype)initWithTitle:(NSString *)title VcClassStr:(NSString *)classStr;
//标题
@property(nonatomic, strong)NSString *itemTitle;
//类名
@property(nonatomic, strong)NSString *itemVCclass;
//是否通过storyboard启动VC
@property(nonatomic, assign)BOOL isStoryboardVC;
//跳转方式
@property(nonatomic, assign)BOOL isPush;

@end
