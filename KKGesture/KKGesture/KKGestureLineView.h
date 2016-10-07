//
//  KKGestureLineView.h
//  KKSideViewController
//
//  Created by MR.KING on 16/7/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  连接两点的线条的抽象类
 */
@interface KKGestureLineView : UIView/* 线条 */

/**
*  线条颜色 default is greenColor
*/
@property(nonatomic,strong)UIColor * lineColor;

/**
 *  错误状态下线条的颜色 default is redcolor
 */
@property(nonatomic,strong)UIColor * errorColor;

/**
 *  线条的宽度
 */
@property(nonatomic,assign)CGFloat lineWidth;

/**
 *  标记是否处于错误的状态
 */
@property(nonatomic,assign)BOOL error;

/**
 *  通过 点 数组来初始化
 *
 *  @param points 所有的 圆 的中心点
 *
 *  @return 实例化对象
 */
- (instancetype)initWithPoints:(CGPoint*)points;

/**
 *  通过 点 数组来初始化
 *
 *  @param frame  view's frame
 *  @param points 所有的 圆 的中心点
 *
 *  @return 实例化对象
 */
- (instancetype)initWithFrame:(CGRect)frame points:(CGPoint*)points;

/**
 *  move to a new point
 *
 *  @param newPoint a new point
 */
-(void)moveToPoint:(CGPoint)newPoint;

/**
 *  线条连接到一个固定的点
 *
 *  @param index 连接到的固定的点的索引
 *  @param point 当前触摸所在的点
 */
-(void)moveToItem:(int)index point:(CGPoint)point;

/**
 *  停止移动，只会保留已经连接到固定的点的线条，未连接到固定点的线条移除
 */
-(void)endMove;

/**
 *  清除所有的缓存
 */
-(void)reset;

@end
