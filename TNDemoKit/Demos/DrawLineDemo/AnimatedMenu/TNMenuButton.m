//
//  TNMenuButton.m
//  AnimationMenuDemo
//
//  Created by 罗义德 on 16/1/13.
//  Copyright © 2016年 lyd. All rights reserved.
//

#import "TNMenuButton.h"

@interface TNMenuButton ()
//点击事件回调的block
@property(nonatomic, strong)void (^clickHandle)(TNMenuButton *button);

@end

@implementation TNMenuButton
#pragma mark system method
/** 实例化选项按钮 */
+ (instancetype)menuButtonWithFrame:(CGRect)frame andClickHandle:(void (^)(TNMenuButton *button))clickHandle {
    TNMenuButton *menuButton = [TNMenuButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = frame;
    menuButton.clickHandle = clickHandle;
    [menuButton addTarget:menuButton action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    return menuButton;
}

- (void)dealloc {
    NSLog(@"菜单按钮被释放!");
}

#pragma mark private method
- (void)buttonClick {
    if (_clickHandle) {
        _clickHandle(self);
    }
}

@end
