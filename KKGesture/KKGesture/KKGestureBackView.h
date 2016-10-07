//
//  KKGestureBackView.h
//  KKSideViewController
//
//  Created by MR.KING on 16/7/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KKGestureItem.h"

#import "KKGestureTrackView.h"

#import "KKGestureView.h"

@interface KKGestureBackView : UIView/*用户放置视图的图层*/
<KKGestureTrackViewDelegate>

/**
 *  create a new KKGestureBackView
 *
 *  @param points        用于设置子视图的 center
 *  @param count         中心点的个数，同样也代表了子视图的个数和创建的圆点个数
 *  @param radius        设置外部大圆的半径
 *  @param inRadius      设置内部小圆的半径
 *  @param errorDuration 错误情况下的停留时间
 *  @param result        当一次手势结束之后回调连接的个数
 *  @param stateBlock    状态变化之后的回调
 *
 *  @return new KKGestureBackView
 */
- (instancetype)initWithPoints:(CGPoint*)points
                         count:(int)count
                        radius:(CGFloat)radius
                      inRadius:(CGFloat)inRadius
                 errorDuration:(double)errorDuration
                        result:(KKGestureViewState(^)(int count))result
                         state:(void(^)(KKGestureViewState newState, KKGestureViewState oldState))stateBlock;

/**
 *  create a new KKGestureBackView
 *
 *  @param points        用于设置子视图的 center
 *  @param count         中心点的个数，同样也代表了子视图的个数和创建的圆点个数
 *  @param radius        设置外部大圆的半径
 *  @param inRadius      设置内部小圆的半径
 *  @param errorDuration 错误情况下的停留时间
 *  @param result        当一次手势结束之后回调连接的个数
 *  @param stateBlock    状态变化之后的回调
 *
 *  @return new KKGestureBackView
 */
-(instancetype)initWithFrame:(CGRect)frame
                      points:(CGPoint*)points
                       count:(int)count
                      radius:(CGFloat)radius
                    inRadius:(CGFloat)inRadius
               errorDuration:(double)errorDuration
                      result:(KKGestureViewState(^)(int count))result
                       state:(void(^)(KKGestureViewState newState, KKGestureViewState oldState))stateBlock;

/**
 *  切换当前状态
 *  
 *  @discuss     将会改变管理的所有的 KKGestureItem 对象 的状态
 *  @param state see `KKGestureItemState`
 */
-(void)changeToState:(KKGestureItemState)state;

/**
 *  切换当前状态
 *
 *  @param state see `KKGestureItemState`
 *  @param index 指定的位置
 */
-(void)changeToState:(KKGestureItemState)state atIndex:(int)index;

/**
 *  更新配置,将会更新管理所有的 KKGestureItemState 对象的属性
 *
 *  @param value   new value
 *  @param keyPath keyPath
 */
-(void)needUpConfigureValue:(id)value keyPath:(NSString*)keyPath;

@end
