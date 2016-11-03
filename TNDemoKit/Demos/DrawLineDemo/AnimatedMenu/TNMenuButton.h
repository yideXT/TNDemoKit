//
//  TNMenuButton.h
//  AnimationMenuDemo
//
//  Created by 罗义德 on 16/1/13.
//  Copyright © 2016年 lyd. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 菜单选项按钮 */

@interface TNMenuButton : UIButton
/** 实例化选项按钮 */
+ (instancetype)menuButtonWithFrame:(CGRect)frame andClickHandle:(void (^)(TNMenuButton *button))clickHandle;

@end
