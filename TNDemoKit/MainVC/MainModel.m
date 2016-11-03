//
//  MainModel.m
//  TNDemoKit
//
//  Created by 罗义德 on 16/1/16.
//  Copyright © 2016年 lyd. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel
- (instancetype)initWithTitle:(NSString *)title VcClassStr:(NSString *)classStr {
    self = [super init];
    if (self) {
        _itemTitle = title;
        _itemVCclass = classStr;
        _isStoryboardVC = YES;
        _isPush = YES;
    }
    return self;
}
@end
