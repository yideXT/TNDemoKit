//
//  TNDrawingBoard.m
//  DrawLineDemo
//
//  Created by 罗义德 on 15/12/7.
//  Copyright © 2015年 lyd. All rights reserved.
//

#import "TNDrawingBoard.h"

@implementation TNDrawingBoard {
    
    //画笔颜色
    UIColor *_brushColor;
    //线条宽度
    CGFloat _lineWidth;
    
    //当前绘制的线条位置
    NSInteger _currentLineIndex;
    
    //线条layer
    CALayer *_lineLayer;
    //线条layer代理
    TNLayerDelegate *_lineLayerDelegate;

    //画板图片
    UIImage *_image;
    //当前图片的宽
    CGFloat _imageWidth;
}

#pragma mark system method
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //图层绘图代理
        _lineLayerDelegate = [[TNLayerDelegate alloc] init];
        _lineLayerDelegate.drawPointArray = [[NSMutableArray alloc] init];
        
        //实例化线条子图层
        _lineLayer = [CALayer layer];
        _lineLayer.frame = self.layer.bounds;
        _lineLayer.delegate = _lineLayerDelegate;
        [self.layer addSublayer:_lineLayer];
        
        _image =[UIImage imageNamed:@"2.png"];
        _imageWidth = 100;
        
        //加一个双击手势
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeImageSize)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    if (_image) {//有图片
        //绘制到指定的矩形中，注意如果大小不合适会会进行拉伸
        [_image drawInRect:CGRectMake(10, 10, _imageWidth, _imageWidth*((CGFloat)_image.size.height/_image.size.width))];
    }
    
    if (_lineLayerDelegate.drawPointArray.count == 0) {
        return;
    }
    
    CGContextRef contex = UIGraphicsGetCurrentContext();
    [self drawViewWithContext:contex];
}

/** 开始触摸 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touche = [touches anyObject];
    CGPoint point = [touche locationInView:self];
    if (CGRectContainsPoint(self.bounds, point)) {//在画板的范围内部
        _currentLineIndex++;
        
        NSMutableArray *currentDrawPoint = [[NSMutableArray alloc] init];
        [_lineLayerDelegate.drawPointArray addObject:currentDrawPoint];
        [currentDrawPoint addObject:[NSValue valueWithCGPoint:point]];
    }
}

/** 触摸移动中 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touche = [touches anyObject];
    CGPoint point = [touche locationInView:self];
    if (CGRectContainsPoint(self.bounds, point)) {//在画板的范围内部
        NSMutableArray *currentDrawPointArray = [_lineLayerDelegate.drawPointArray lastObject];
        [currentDrawPointArray addObject:[NSValue valueWithCGPoint:point]];
        
        if (_isDrawMainLayer) {
            [self setNeedsDisplay];
        }else {
            // 调用此方法，drawLayer: inContext:方法才会被调用。
            [_lineLayer setNeedsDisplay];
        }
    }
}

/** 触摸结束 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self sendDrawLinePointsData];
}

/** 触摸中断删除 */
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self sendDrawLinePointsData];
}

/** 开始发送数据 */
- (void)sendDrawLinePointsData {
    //绘图结束，开始传输
    if (_drawingLineHandle && _lineLayerDelegate.drawPointArray.count>0) {
        
        NSMutableArray *pointArray = [[NSMutableArray alloc] init];
        //数据处理，坐标点处理成比例
        for (NSValue *pointValue in [_lineLayerDelegate.drawPointArray lastObject]) {
            
            CGFloat x_percent = (CGFloat)[pointValue CGPointValue].x/CGRectGetWidth(self.frame);
            CGFloat y_percent = (CGFloat)[pointValue CGPointValue].y/CGRectGetHeight(self.frame);
            
            CGPoint point = CGPointMake(x_percent, y_percent);
            [pointArray addObject:[NSValue valueWithCGPoint:point]];
        }
        
        _drawingLineHandle(pointArray,_lineLayerDelegate.drawPointArray.count);
    }
}

#pragma mark private method
/** 绘制图片和线条 */
- (void)drawViewWithContext:(CGContextRef)context {
    
    //设置线条终点形状 --- 圆形
    CGContextSetLineCap(context, kCGLineCapRound);
    //设置线条连接处，拐点圆滑
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    //画线
    for (NSArray *drawArray in _lineLayerDelegate.drawPointArray) {
        
        if (drawArray.count>1) {
            //开始画图
            CGContextBeginPath(context);
            //起点
            //------------------------
            CGPoint myStartPoint=[[drawArray firstObject] CGPointValue];
            CGContextMoveToPoint(context,myStartPoint.x,myStartPoint.y);
            
            //把move的点全部加入　数组
            for (NSValue *pointValue in drawArray) {
                CGPoint point = [pointValue CGPointValue];
                CGContextAddLineToPoint(context,point.x,point.y);
            }
            
            //绘制画笔颜色
            CGContextSetStrokeColorWithColor(context,[UIColor redColor].CGColor);
            CGContextSetFillColorWithColor (context,[UIColor greenColor].CGColor);
            
            //-------------------------------------------
            //绘制画笔宽度
            CGContextSetLineWidth(context, 2.0);
            //把数组里面的点全部画出来
            CGContextStrokePath(context);
        }
    }
}

//改变图片绘制的大小
- (void)changeImageSize {
    if (_imageWidth == 100) {
        _imageWidth = 200;
    }else {
        _imageWidth = 100;
    }
    
    //重新绘制
    [self setNeedsDisplay];
}

#pragma mark public method
/** 选择画笔颜色 默认红色 */
- (void)setBrushColor:(UIColor *)color {
    _brushColor = color;
}

/** 清空画板 */
- (void)clearBoard {
    [_lineLayerDelegate.drawPointArray removeAllObjects];
    [_lineLayer setNeedsDisplay];
}

/** 绘制回退 */
- (void)backBeforeDraw {
    [_lineLayerDelegate.drawPointArray removeLastObject];
    [_lineLayer setNeedsDisplay];
}

/** 外部控制画线 */
- (void)drawLineWithPointArray:(NSArray *)pointArray lineIndex:(NSInteger)lineIndex {
    //处理外部传过来的数据
    NSMutableArray *availablePointArray = [[NSMutableArray alloc] init];
    //数据处理，坐标点处理成比例
    for (NSValue *pointValue in pointArray) {
        CGFloat x = [pointValue CGPointValue].x*CGRectGetWidth(self.frame);
        CGFloat y = [pointValue CGPointValue].y*CGRectGetHeight(self.frame);
        
        CGPoint point = CGPointMake(x, y);
        
        [availablePointArray addObject:[NSValue valueWithCGPoint:point]];
    }
    
    NSMutableArray *currentArray;
    if (lineIndex>_lineLayerDelegate.drawPointArray.count) {
        currentArray = [[NSMutableArray alloc] initWithArray:availablePointArray];
        [_lineLayerDelegate.drawPointArray addObject:currentArray];

    }else {
        currentArray = [_lineLayerDelegate.drawPointArray objectAtIndex:lineIndex-1];
        [currentArray removeAllObjects];
        [currentArray addObjectsFromArray:availablePointArray];
    }
    //绘制
    [_lineLayer setNeedsDisplay];
}

@end

/** 画图layer代理类 */
@implementation TNLayerDelegate 
#pragma mark system method
- (instancetype)init {
    self = [super init];
    if (self) {
        //设置默认值
        _brushColor = [UIColor redColor];
        _lineWidth = 2.0;
    }
    return self;
}

/** 绘图的方法 */
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    if (_drawPointArray.count == 0) {
        return;
    }
    [self drawViewWithContext:ctx];
}

#pragma mark private method
/** 绘制图片和线条 */
- (void)drawViewWithContext:(CGContextRef)context {
    
    //设置线条终点形状 --- 圆形
    CGContextSetLineCap(context, kCGLineCapRound);
    //设置线条连接处，拐点圆滑
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    //画线
    for (NSArray *drawArray in _drawPointArray) {
        
        if (drawArray.count>1) {
            //开始画图
            CGContextBeginPath(context);
            //起点
            //------------------------
            CGPoint myStartPoint=[[drawArray firstObject] CGPointValue];
            CGContextMoveToPoint(context,myStartPoint.x,myStartPoint.y);
            
            //把move的点全部加入　数组
            for (NSValue *pointValue in drawArray) {
                CGPoint point = [pointValue CGPointValue];
                CGContextAddLineToPoint(context,point.x,point.y);
            }
            
            //绘制画笔颜色
            CGContextSetStrokeColorWithColor(context,_brushColor.CGColor);
            CGContextSetFillColorWithColor (context,[UIColor greenColor].CGColor);
            
            //-------------------------------------------
            //绘制画笔宽度
            CGContextSetLineWidth(context, _lineWidth);
            //把数组里面的点全部画出来
            CGContextStrokePath(context);
        }
    }
}

@end
