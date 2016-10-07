//
//  KKGestureTrackView.h
//  KKSideViewController
//
//  Created by MR.KING on 16/7/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KKGestureTrackView;

/**
 *  protocol for KKGestureTrackView
 */
@protocol KKGestureTrackViewDelegate <NSObject>

/**
 *  当用户触摸的点不在任何一个原点中的情况下，回调用户触摸的位置
 *
 *  @param gestureTrackView `KKGestureTrackView`
 *  @param point            用户的触摸事件映射在呈现 `KKGestureBackView` 上的点
 */
-(void)gestureTrackView:(KKGestureTrackView *)gestureTrackView moveToNewPoint:(CGPoint)point;

/**
 *  当用户触摸的点在其中一个 圆 内部的情况下的回调
 *
 *  @param gestureTrackView `KKGestureTrackView`
 *  @param index            用来标记当前触摸点所在的 圆 的索引
 *  @param newPoint         用户的触摸事件映射在呈现 `KKGestureBackView` 上的点
 */
-(void)gestureTrackView:(KKGestureTrackView *)gestureTrackView moveToNewItem:(int)index point:(CGPoint)newPoint;

/**
 *  用户的触摸停止的情况下的回调
 *
 *  @param gestureTrackView `KKGestureTrackView`
 */
-(void)gestureTrackViewEndTrack:(KKGestureTrackView *)gestureTrackView;

@end


/**
 *  用于监控并且处理用户的触摸事件
 */
@interface KKGestureTrackView : UIView/* 用于处理手势 */

/**
*  所有 圆 的中心点
*/
@property(nonatomic,assign,readonly)CGPoint * points;

/**
 *  每个 圆 的半径
 */
@property(nonatomic,assign,readonly)CGFloat itemRadius;

/**
 *  手势视图中 圆 的个数
 */
@property(nonatomic,assign,readonly)int count;

/**
 *  触摸事件所映射的视图
 */
@property(nonatomic,weak,readonly)UIView * refrenceView;

/**
 *  设置回调的对象
 */
@property(nonatomic,weak)id <KKGestureTrackViewDelegate>delegate;

/**
 *  init
 *
 *  @param points 所有 圆 的中心点
 *  @param count  手势视图中 圆 的个数
 *  @param radius 圆 的半径，以底部大圆的半径为标准
 *
 *  @return 实例化对象
 */

-(instancetype)initWithPoints:(CGPoint*)points
                        count:(int)count
                       radius:(CGFloat)radius
                 refrenceView:(UIView*)refrenceView;

/**
 *  init
 *
 *  @param points 所有 圆 的中心点
 *  @param count  手势视图中 圆 的个数
 *  @param radius 圆 的半径，以底部大圆的半径为标准
 *
 *  @return 实例化对象
 */

-(instancetype)initWithFrame:(CGRect)frame
                      points:(CGPoint*)points
                       count:(int)count
                      radius:(CGFloat)radius
                refrenceView:(UIView*)refrenceView;

@end
