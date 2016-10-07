//
//  KKGestureView.h
//  KKSideViewController
//
//  Created by MR.KING on 16/7/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KKGestureView;


typedef enum : NSUInteger {
    KKGestureViewStateNormal, // 正常状态
    KKGestureViewStateConnecting, // 正在连接状态
    KKGestureViewStateError, // 错误状态
} KKGestureViewState;


/**
 *  delegate for KKGestureView
 */

@protocol KKGestureViewDelegate <NSObject>

/// 此次结束的时候连接的点的个数
-(KKGestureViewState)gestureView:(KKGestureView*)gestureView currentConnectPoints:(int)num;

/// 此次结束的时候状态的变化
-(void)gestureView:(KKGestureView*)gestureView
     changeToState:(KKGestureViewState)currentState
         fromState:(KKGestureViewState)fromState;

@end



/**
 *  手势视图
 */
@interface KKGestureView : UIView

/*!
 
 @property  手势的当前状态
 
 @abstract  标记手势的当前的状态 see KKGestureViewState
 
 */
@property(nonatomic,assign)KKGestureViewState state;


/*!
 
 @property  错误的状态下停留的时间
 
 @abstract  当 delegate 实现的方法 -gestureView:currentConnectPoints: 返回
            的状态为 `KKGestureViewStateError` 
 
 */
@property(nonatomic,assign)NSTimeInterval errorDuration;


/**
 *
 *  @property   delegate for KKGestureView
 *
 *  @see        `KKGestureViewDelegate`
 *
 */
@property(nonatomic,weak)id <KKGestureViewDelegate>delegate;

/// 手势图层在本图层的边距
@property(nonatomic,assign)UIEdgeInsets edgeInsets;

/// 外边圆的半径
@property(nonatomic,assign,readonly)CGFloat itemRadius;

/// 内圆的半径
@property(nonatomic,assign)CGFloat itemInCircleRadius;

/// 行数 default is 3
@property(nonatomic,assign)int rows;

/// 列数 default is 3
@property(nonatomic,assign)int cols;




/// 大圆背景颜色
@property(nonatomic,strong)UIColor * itemBackGroundColor;

/// 大圆边框颜色
@property(nonatomic,strong)UIColor * itemBorderColor;

/// 大圆选中下的背景颜色
@property(nonatomic,strong)UIColor * itemSeletedBackGroundColor;

/// 大圆选中下的边框颜色
@property(nonatomic,strong)UIColor * itemSeletedBorderColor;

/// 大圆错误下的背景颜色
@property(nonatomic,strong)UIColor * itemErrorBackGroundColor;

/// 大圆错误下的边框颜色
@property(nonatomic,strong)UIColor * itemErrorBorderColor;

/// 大圆边框宽度
@property(nonatomic,assign)CGFloat itemBorderWidth;




/// 小圆背景
@property(nonatomic,strong)UIColor * itemInBackGroundColor;

/// 小圆选中下的背景颜色
@property(nonatomic,strong)UIColor * itemInSeletedBackGroundColor;

/// 小圆选中下的边框颜色
@property(nonatomic,strong)UIColor * itemInSeletedBorderColor;

/// 小圆边框颜色
@property(nonatomic,strong)UIColor * itemInBorderColor;

/// 小圆错误下的背景颜色
@property(nonatomic,strong)UIColor * itemInErrorBackGroundColor;

/// 小圆错误下的边框颜色
@property(nonatomic,strong)UIColor * itemInErrorBorderColor;

/// 小圆边框宽度
@property(nonatomic,assign)CGFloat itemInBorderWidth;


@end
