//
//  KKGestureLineView.m
//  KKSideViewController
//
//  Created by MR.KING on 16/7/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "KKGestureLineView.h"

@interface KKGestureLineView()
{
    UIBezierPath * _currentPath;
}

@property(nonatomic,strong)NSMutableArray * arrIndex;

/// 代表原始的路径
@property(nonatomic,strong)UIBezierPath * previousPath;

@property(nonatomic,assign)CGPoint * points;

@end

@implementation KKGestureLineView

- (instancetype)initWithPoints:(CGPoint*)points
{
    self = [super init];
    if (self) {
        _points = points;
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame points:(CGPoint*)points
{
    self = [super initWithFrame:frame];
    if (self) {
        _points = points;
        [self initData];
    }
    return self;
}

-(void)initData{
    self.backgroundColor = [UIColor clearColor];
    _errorColor = [UIColor redColor];
    _lineWidth = 10.0f;
    _lineColor = [UIColor greenColor];
    _arrIndex = [[NSMutableArray alloc]init];
    self.previousPath = [UIBezierPath bezierPath];
}

-(BOOL)saveForNewItem:(int)index{
    if ([self.arrIndex containsObject:@(index)]) {
        return NO;
    }
    [self.arrIndex addObject:@(index)];
    return YES;
}

-(void)moveToItem:(int)index point:(CGPoint)point{
    if (![self saveForNewItem:index]) {
        [self moveToPoint:point];
        return;
    }
    if (_arrIndex.count > 1) {
        [self.previousPath addLineToPoint:_points[index]];
        [self moveToPoint:point];
    }else if (_arrIndex.count == 1){
        [self.previousPath moveToPoint:_points[index]];
    }
}

-(void)moveToPoint:(CGPoint)newPoint{
    if (_arrIndex.count) {
        UIBezierPath * new = [UIBezierPath bezierPath];
        [new appendPath:self.previousPath];
        [new addLineToPoint:newPoint];
        [self needsDisplayPath:new];
    }
}

-(void)endMove{
    [self needsDisplayPath:self.previousPath];
}

-(void)needsDisplayPath:(UIBezierPath*)path{
    _currentPath = path;
    [self setNeedsDisplay];
}

-(void)reset{
    _error = NO;
    [self.previousPath removeAllPoints];;
    [_arrIndex removeAllObjects];
    [self needsDisplayPath:nil];
}

-(void)setError:(BOOL)error{
    _error = error;
}

- (void)drawRect:(CGRect)rect {
    if (!_currentPath) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetLineWidth(context, _lineWidth);
    
    CGContextAddPath(context, _currentPath.CGPath);
    
    CGContextSetStrokeColorWithColor(context, (_error)?_errorColor.CGColor:_lineColor.CGColor);
    
    CGContextSetRGBFillColor(context, 0, 0, 0, 0);
        
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

/*
 -(UIBezierPath *)previousPath{
 // 大于1的情况下说明之前才存在直线
 if (self.arrIndex.count >1) {
 UIBezierPath * path = [UIBezierPath bezierPath];
 [path moveToPoint:_points[[_arrIndex[0] intValue]]];
 
 for (int i = 1; i < self.arrIndex.count; i++) {
 [path addLineToPoint:_points[[_arrIndex[i] intValue]]];
 }
 }else{
 return nil;
 }
 }
 */


@end
