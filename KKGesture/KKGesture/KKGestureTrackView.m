//
//  KKGestureTrackView.m
//  KKSideViewController
//
//  Created by MR.KING on 16/7/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "KKGestureTrackView.h"

#import "math.h"

@interface KKGestureTrackView ()


/**
 *  所有 圆 的中心点
 */
@property(nonatomic,assign)CGPoint * points;

/**
 *  每个 圆 的半径，以底部大圆的半径为标准
 */
@property(nonatomic,assign)CGFloat itemRadius;

/**
 *  手势视图中 圆 的个数
 */
@property(nonatomic,assign)int count;

/**
 *  触摸事件所映射的视图
 */
@property(nonatomic,weak)UIView * refrenceView;

@end

double distanceBetweenPoints(CGPoint poi1, CGPoint poi2){
    return sqrt(pow(poi1.x - poi2.x, 2) + pow((poi2.y - poi1.y), 2));
}

@implementation KKGestureTrackView


-(instancetype)initWithPoints:(CGPoint*)points
                        count:(int)count
                       radius:(CGFloat)radius
                 refrenceView:(UIView*)refrenceView{
    self = [super init];
    if (self) {
        self.points = points;
        self.count = count;
        self.itemRadius = radius;
        self.refrenceView = refrenceView;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
                      points:(CGPoint*)points
                       count:(int)count
                      radius:(CGFloat)radius
                refrenceView:(UIView*)refrenceView{
    self = [super initWithFrame:frame];
    if (self) {
        self.points = points;
        self.count = count;
        self.itemRadius = radius;
    }
    return self;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self moveToNewPoint:[touches.anyObject locationInView:self.refrenceView]];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endMove];
}

-(void)endMove{
    if (self.delegate &&
        ([self.delegate respondsToSelector:@selector(gestureTrackViewEndTrack:)])) {
        [self.delegate gestureTrackViewEndTrack:self];
    }
}

-(void)moveToNewPoint:(CGPoint)point{
    
    // 判断是否进入一个新的item
    BOOL newItem = [self delegateForNewItemWithPoint:point];
    
    // 否则回调新的坐标
    if (!newItem) {
        [self delegateForNewPoint:point];
    }
}

// 判断是否在一个圆内部
-(BOOL)delegateForNewItemWithPoint:(CGPoint)point{
    for (int i = 0; i < _count; i++) {
        if (distanceBetweenPoints(point, _points[i]) < _itemRadius) {
            if (self.delegate &&
                ([self.delegate respondsToSelector:@selector(gestureTrackView:moveToNewItem:point:)])) {
                [self.delegate gestureTrackView:self moveToNewItem:i point:point];
            }
            return YES;
        }
    }
    return NO;
}

/*
// 获取当前点大约是在哪四个原点之间，减少判断的次数
-(CGPoint*)getEstimatePointsByPoint:(CGPoint)point{
    
    // 在第一列
    if (point.x < self.itemRadius) {
        
    }
}
 */

-(void)delegateForNewPoint:(CGPoint)point{
    if (self.delegate &&
        ([self.delegate respondsToSelector:@selector(gestureTrackView:moveToNewPoint:)])) {
        [self.delegate gestureTrackView:self moveToNewPoint:point];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
