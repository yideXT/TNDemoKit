//
//  UIViewController+NavigationBarItem.m
//  1001
//
//  Created by 罗义德 on 15/7/14.
//  Copyright (c) 2015年 ChuXiong. All rights reserved.
//

#import "UIViewController+NavigationBarItem.h"

//字体大小
CGFloat const TEXT_FONT = 17;

@implementation UIViewController (NavigationBarItem)

/** 左边按钮 */
- (void)createLeftItemWithImage:(NSString *)imageName target:(id)target selector:(SEL)sel tag:(NSInteger)tag {
    UIButton *leftItem = [self buttonWithImage:imageName title:nil target:target selector:sel tag:tag];
    leftItem.frame = CGRectMake(0, 2, 40, 40);

    leftItem.imageEdgeInsets = UIEdgeInsetsMake(0, -(40-CGRectGetWidth(leftItem.imageView.frame))/2, 0, (40-CGRectGetWidth(leftItem.imageView.frame))/2);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
}

- (void)createLeftItemWithTitle:(NSString *)title textColor:(UIColor *)color target:(id)target selector:(SEL)sel tag:(NSInteger)tag {
    UIButton *leftItem = [self buttonWithImage:nil title:title target:target selector:sel tag:tag];
    [leftItem setTitleColor:color forState:UIControlStateNormal];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    CGSize size = [title boundingRectWithSize:CGSizeMake(100, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:leftItem.titleLabel.font} context:nil].size;
    leftItem.frame = CGRectMake(0, 2, size.width, 40);
}

/** 导航栏右边按钮 */
- (void)createRightItemWithImages:(NSArray *)imageNameArr target:(id)target selector:(SEL)sel tags:(NSArray *)tagArr {
    
    NSMutableArray *buttonArr = [[NSMutableArray alloc] init];
    for (int i=0; i<imageNameArr.count; i++) {
        UIButton *rightItem = [self buttonWithImage:[imageNameArr objectAtIndex:i] title:nil target:target selector:sel tag:[[tagArr objectAtIndex:i] integerValue]];
        rightItem.frame = CGRectMake(0, 2, 40, 40);
        
        [rightItem addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
        rightItem.imageEdgeInsets = UIEdgeInsetsMake(0, (40-CGRectGetWidth(rightItem.imageView.frame))/2, 0, -(40-CGRectGetWidth(rightItem.imageView.frame))/2);
        rightItem.adjustsImageWhenHighlighted = NO;
        [buttonArr addObject:[[UIBarButtonItem alloc] initWithCustomView:rightItem]];
    }
    
    self.navigationItem.rightBarButtonItems = buttonArr;
}

- (UIButton *)createRightItemWithTitle:(NSString *)title textColor:(UIColor *)color target:(id)target selector:(SEL)sel tag:(NSInteger)tag {
    UIButton *rightItem = [self buttonWithImage:nil title:title target:target selector:sel tag:tag];
    [rightItem setTitleColor:color forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    
    CGSize size = [title boundingRectWithSize:CGSizeMake(100, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:rightItem.titleLabel.font} context:nil].size;
    rightItem.frame = CGRectMake(0, 2, size.width, 40);
    rightItem.adjustsImageWhenHighlighted = NO;

    return rightItem;
}

- (UIButton *)createRightItemWithImage:(NSString *)imageName target:(id)target selector:(SEL)sel tag:(NSInteger)tag {
    UIButton *rightItem = [self buttonWithImage:imageName title:nil target:target selector:sel tag:tag];
    rightItem.frame = CGRectMake(0, 2, 40, 40);
    
    rightItem.imageEdgeInsets = UIEdgeInsetsMake(0, (40-rightItem.imageView.frame.size.width)/2, 0, -(40-rightItem.imageView.frame.size.width)/2);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    
    return rightItem;
}

#pragma mark private method
- (UIButton *)buttonWithImage:(NSString *)image title:(NSString *)title target:(id)target selector:(SEL)sel tag:(NSInteger)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:TEXT_FONT];
    }
    if (image) {
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    button.adjustsImageWhenHighlighted = NO;
    return button;
}

@end


