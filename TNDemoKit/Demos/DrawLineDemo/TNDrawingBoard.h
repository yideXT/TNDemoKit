//
//  TNDrawingBoard.h
//  DrawLineDemo
//
//  Created by 罗义德 on 15/12/7.
//  Copyright © 2015年 lyd. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 画板类 */

@interface TNDrawingBoard : UIView
/** 选择画笔颜色 默认红色 */
- (void)setBrushColor:(UIColor *)color;
/** 清空画板 */
- (void)clearBoard;
/** 绘制回退 */
- (void)backBeforeDraw;

/** 外部控制画线:pointArray,绘图的坐标数组 lineCount,当前绘制的线条数 */
- (void)drawLineWithPointArray:(NSArray *)pointArray lineIndex:(NSInteger)lineIndex;

/** 正在绘图中回调:pointArray,绘图的坐标数组 lineCount,当前绘制的线条数 */
@property(nonatomic, strong)void (^drawingLineHandle)(NSArray *pointArray,NSInteger lineIndex);
/** 是否在主layer上绘制 */
@property(nonatomic, assign)BOOL isDrawMainLayer;

@end

/** 画图layer代理类 */
@interface TNLayerDelegate : NSObject
/** 绘图的方法 */
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;

/** 绘制的画图点的坐标 --- 二维数组 */
@property(nonatomic, strong)NSMutableArray *drawPointArray;
/** 画笔颜色 */
@property(nonatomic, strong)UIColor *brushColor;
/** 线条宽度 */
@property(nonatomic, assign)CGFloat lineWidth;

@end

