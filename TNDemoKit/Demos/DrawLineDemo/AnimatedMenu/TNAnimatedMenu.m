//
//  TNAnimatedMenu.m
//  AnimationMenuDemo
//
//  Created by 罗义德 on 16/1/13.
//  Copyright © 2016年 lyd. All rights reserved.
//

#import "TNAnimatedMenu.h"

@interface TNAnimatedMenu () {
    //菜单按钮视图数组
    NSMutableArray *_menuItemArray;
    //菜单按钮
    TNMenuButton *_menuButton;
}

@end

@implementation TNAnimatedMenu
#pragma mark system method
- (void)awakeFromNib {
    
    CGRect rect = CGRectMake(90, 90, 40, 40);
    __weak typeof(self)mySelf = self;
    _menuButton = [TNMenuButton menuButtonWithFrame:rect andClickHandle:^(TNMenuButton *button){
        [mySelf showOrHideMenuItemButton:!button.selected];
        button.selected = !button.selected;
    }];
    
    _menuButton.layer.masksToBounds = YES;
    _menuButton.layer.cornerRadius = CGRectGetWidth(_menuButton.frame)/2;
    _menuButton.backgroundColor = [UIColor grayColor];
    _menuButton.layer.shadowColor = [[UIColor blackColor] CGColor];
    _menuButton.layer.shadowOpacity = 0.6;
    _menuButton.layer.shadowRadius = 2.0;
    _menuButton.layer.shadowOffset = CGSizeMake(0, 3);
    [self addSubview:_menuButton];
}

/** 实例化一个菜单 */
- (instancetype)initWithFrame:(CGRect)frame defaultMeneImage:(UIImage *)image {
    
    CGRect rect = frame;
    rect.origin.x -= 90;
    rect.origin.y -= 90;
    rect.size.width += 90;
    rect.size.height += 90;
    self = [super initWithFrame:rect];
    if (self) {
        
        frame.origin.x = 90;
        frame.origin.y = 90;
        __weak typeof(self)mySelf = self;
        _menuButton = [TNMenuButton menuButtonWithFrame:frame andClickHandle:^(TNMenuButton *button){
            [mySelf showOrHideMenuItemButton:!button.selected];
            button.selected = !button.selected;
        }];
        
        _menuButton.layer.masksToBounds = YES;
        _menuButton.layer.cornerRadius = CGRectGetWidth(_menuButton.frame)/2;
        _menuButton.backgroundColor = [UIColor grayColor];
        _menuButton.layer.shadowColor = [[UIColor blackColor] CGColor];
        _menuButton.layer.shadowOpacity = 0.6;
        _menuButton.layer.shadowRadius = 2.0;
        _menuButton.layer.shadowOffset = CGSizeMake(0, 3);
        [self addSubview:_menuButton];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"菜单被销毁!");
}

#pragma mark private method
/** 显示或者收起菜单选项按钮 */
- (void)showOrHideMenuItemButton:(BOOL)show {
    
    int i=0;
    if (show) {//弹出菜单按钮
        NSLog(@"弹出菜单按钮");
        
        for (UIView *subView in _menuItemArray) {
            subView.alpha = 0;
            [UIView animateWithDuration:0.25
                                  delay:0.1*i
                 usingSpringWithDamping:0.7
                  initialSpringVelocity:0.4
                                options:UIViewAnimationOptionAllowUserInteraction animations:^{
                                    subView.alpha = 1;
                                    subView.transform = [self getTransformForPopupViewAtIndex:i];
                                } completion:^(BOOL finished) {
                                    
                                }];
            i++;
        }
        
    }else {//收起菜单按钮
        NSLog(@"收起菜单按钮");
        
        for (UIView *subView in _menuItemArray) {
            [UIView animateWithDuration:0.25 delay:0.1*i options:UIViewAnimationOptionAllowUserInteraction animations:^{
                subView.transform = CGAffineTransformIdentity;
                subView.alpha = 0;

            } completion:^(BOOL finished) {
            }];
            i++;
        }
    }
}

- (CGAffineTransform) getTransformForPopupViewAtIndex: (NSInteger) index {
    CGFloat newAngle = 180 + (90.0/(_menuItemArray.count-1) * index);
    CGFloat deltaY = 90 * cos(newAngle/ 180.0 * M_PI);
    CGFloat deltaX = 90 * sin(newAngle/ 180.0 * M_PI);
    return CGAffineTransformMakeTranslation(deltaX, deltaY);
}

#pragma mark public method
/** 添加菜单按钮  */
- (void)addMenuButtonWithImage:(NSString *)image andClickCompletion:(void (^)(TNMenuButton *button))completion {
    
    CGRect rect = CGRectMake(0, 0, 30, 30);
    
    TNMenuButton *menuItem = [TNMenuButton menuButtonWithFrame:rect andClickHandle:completion];
    menuItem.center = _menuButton.center;
    menuItem.layer.masksToBounds = YES;
    menuItem.layer.cornerRadius = CGRectGetWidth(menuItem.frame)/2;
    menuItem.layer.shadowColor = [[UIColor blackColor] CGColor];
    menuItem.layer.shadowOpacity = 0.6;
    menuItem.layer.shadowRadius = 2.0;
    menuItem.layer.shadowOffset = CGSizeMake(0, 3);
    
    if (image.length>0) {
        [menuItem setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }else {
        menuItem.backgroundColor = [UIColor redColor];
    }
    
    if (!_menuItemArray) {
        _menuItemArray = [[NSMutableArray alloc] init];
    }
    [_menuItemArray addObject:menuItem];
    [self insertSubview:menuItem belowSubview:_menuButton];
}

/** 收起菜单按钮 */
- (void)retract {
    
}

@end
