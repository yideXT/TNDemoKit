//
//  TNAnimatedMenu.h
//  AnimationMenuDemo
//
//  Created by 罗义德 on 16/1/13.
//  Copyright © 2016年 lyd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNMenuButton.h"

/** 菜单类 */

@interface TNAnimatedMenu : UIView
/** 实例化一个菜单 */
- (instancetype)initWithFrame:(CGRect)frame defaultMeneImage:(UIImage *)image;
/** 添加菜单按钮  */
- (void)addMenuButtonWithImage:(NSString *)image andClickCompletion:(void (^)(TNMenuButton *button))completion;
/** 收起菜单按钮 */
- (void)retract;

/** 统一回调 index:按钮添加的顺序 */
@property(nonatomic, strong)void (^clickMenuItemCompletion)(NSInteger index, TNMenuButton *button);

@end
